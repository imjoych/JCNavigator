//
//  JCNavigator.m
//  JCNavigator
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCNavigator.h"
#import "JCURLMap.h"

@interface JCNavigator ()

@property (nonatomic, strong) NSMutableSet *URLMaps;
@property (nonatomic, strong) NSMutableDictionary *hostListForScheme;
@property (nonatomic, strong) Class navigationControllerClass;
@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UINavigationController *rootNavigationController;
@property (nonatomic, copy) JCNavigatorSettingBlock popButtonBlock;
@property (nonatomic, copy) JCNavigatorSettingBlock dismissButtonBlock;

@end

@implementation JCNavigator

- (instancetype)init
{
    if (self = [super init]) {
        _URLMaps = [NSMutableSet set];
        _hostListForScheme = [NSMutableDictionary dictionary];
        _navigationControllerClass = [UINavigationController class];
    }
    return self;
}

#pragma mark - Public

+ (instancetype)sharedNavigator
{
    static JCNavigator *sharedNavigator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNavigator = [[self alloc] init];
    });
    return sharedNavigator;
}

- (void)addURLScheme:(NSString *)scheme hostList:(NSArray<NSString *> *)hostList
{
    NSMutableArray *lowercaseHostList = [NSMutableArray arrayWithCapacity:hostList.count];
    for (NSString *host in hostList) {
        [lowercaseHostList addObject:[host lowercaseString]];
    }
    self.hostListForScheme[[scheme lowercaseString]] = [lowercaseHostList copy];
}

- (void)addURLMap:(JCURLMap *)URLMap
{
    [self.URLMaps addObject:URLMap];
}

- (void)popButtonSettingBlock:(JCNavigatorSettingBlock)block
{
    _popButtonBlock = block;
}

- (void)dismissButtonSettingBlock:(JCNavigatorSettingBlock)block
{
    _dismissButtonBlock = block;
}

- (void)setNavigationControllerClass:(Class)navigationControllerClass
{
    _navigationControllerClass = navigationControllerClass;
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    _rootViewController = rootViewController;
    if ([rootViewController isKindOfClass:self.navigationControllerClass]) {
        _rootNavigationController = (UINavigationController *)rootViewController;
    } else {
        _rootNavigationController = [[self.navigationControllerClass alloc] initWithRootViewController:rootViewController];
    }
    [UIApplication sharedApplication].delegate.window.rootViewController = _rootNavigationController;
}

- (UINavigationController *)rootNavigationController
{
    return _rootNavigationController;
}

- (UIViewController *)topViewController
{
    return self.rootNavigationController.topViewController;
}

- (UIViewController *)visibleViewController
{
    return self.rootNavigationController.visibleViewController;
}

#pragma mark - Open URL operation

- (void)openURLString:(NSString *)URLString
{
    if (![URLString isKindOfClass:[NSString class]]) {
        return;
    }
    [self openURL:[NSURL URLWithString:URLString]];
}

- (void)openURL:(NSURL *)URL 
{
    [self openURL:URL completionHandler:nil];
}

- (void)openURL:(NSURL *)URL completionHandler:(void (^)(BOOL))completionHandler
{
    [self openURL:URL options:nil completionHandler:completionHandler];
}

- (void)openURL:(NSURL *)URL options:(NSDictionary *)options completionHandler:(void (^)(BOOL))completionHandler
{
    if (![URL isKindOfClass:[NSURL class]] || !URL.scheme || !URL.host) {
        [self callbackWithURL:nil options:nil message:@"Invalid URL!" completionHandler:completionHandler];
        return;
    }
    NSString *lowercaseScheme = [URL.scheme lowercaseString];
    if (![self.hostListForScheme.allKeys containsObject:lowercaseScheme]) {
        [self callbackWithURL:URL options:options message:[NSString stringWithFormat:@"URL scheme %@ is not found !", lowercaseScheme] completionHandler:completionHandler];
        return;
    }
    NSArray *hostList = self.hostListForScheme[lowercaseScheme];
    NSString *lowercaseHost = [URL.host lowercaseString];
    if (![hostList containsObject:lowercaseHost]) {
        [self callbackWithURL:URL options:options message:[NSString stringWithFormat:@"URL host %@ for URL scheme %@ is not found !", lowercaseHost, lowercaseScheme] completionHandler:completionHandler];
        return;
    }
    JCURLMap *URLMap = [self URLMapForURL:URL];
    if (!URLMap) {
        [self callbackWithURL:URL options:options message:[NSString stringWithFormat:@"The corresponding URLMap for %@ is not found !", URL.absoluteString] completionHandler:completionHandler];
        return;
    }
    UIViewController *viewController = nil;
    Class viewControllerClass = [URLMap viewControllerClassForURL:URL];
    if ([[URLMap reuseViewControllerClasses] containsObject:viewControllerClass]) {
        viewController = [self existedViewControllerForClass:viewControllerClass];
        if (viewController) {
            [self setViewController:viewController URLMap:URLMap URLQuery:URL.query];
            [self openPreviousVCOfWillOpenedVC:viewController completion:^(BOOL success) {
                if (success) {
                    [self openViewController:viewController presented:NO animated:YES];
                }
                if (completionHandler) {
                    completionHandler(YES);
                }
            }];
            return;
        }
    }
    if (!viewController) {
        viewController = [[viewControllerClass alloc] init];
    }
    [self setViewController:viewController URLMap:URLMap URLQuery:URL.query];
    [self openViewController:viewController presented:NO animated:YES];
    if (completionHandler) {
        completionHandler(YES);
    }
}

- (void)callbackWithURL:(NSURL *)URL options:(NSDictionary *)options message:(NSString *)message completionHandler:(void (^)(BOOL))completionHandler
{
    if ([URL isKindOfClass:[NSURL class]] && [[UIApplication sharedApplication] canOpenURL:URL]) {
        [self openSpecifiedURL:URL options:options completionHandler:completionHandler];
        return;
    }
    if (completionHandler) {
        completionHandler(NO);
    }
#ifdef DEBUG
    NSLog(@"%@", message);
#endif
}

- (void)openSpecifiedURL:(NSURL *)URL options:(NSDictionary *)options completionHandler:(void (^)(BOOL))completionHandler
{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL options:options completionHandler:^(BOOL success) {
            if (completionHandler) {
                completionHandler(success);
            }
        }];
        return;
    }
    BOOL success = [[UIApplication sharedApplication] openURL:URL];
    if (completionHandler) {
        completionHandler(success);
    }
}

- (void)setViewController:(UIViewController *)viewController URLMap:(JCURLMap *)URLMap URLQuery:(NSString *)URLQuery
{
    NSDictionary *parameters = [self parseURLQuery:URLQuery];
    NSDictionary *mapForClasses = [URLMap propertiesMapOfURLQueryForClasses];
    NSDictionary *propertiesMap = mapForClasses[NSStringFromClass([viewController class])];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *realKey = nil;
        if (propertiesMap) {
            realKey = propertiesMap[key];
        }
        if (!realKey) {
            realKey = key;
        }
        if ([viewController respondsToSelector:NSSelectorFromString(realKey)]) {
            @try {
                [viewController setValue:obj forKey:realKey];
            } @catch (NSException *exception) {
#ifdef DEBUG
                NSLog(@"%@", exception);
#endif
            }
        }
    }];
}

- (NSDictionary *)parseURLQuery:(NSString *)query
{
    if (![query isKindOfClass:[NSString class]] || query.length < 1) {
        return nil;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs) {
        NSArray *keyValue = [pair componentsSeparatedByString:@"="];
        if (keyValue.count == 2) {
            NSString *key = [keyValue[0] stringByRemovingPercentEncoding];
            NSString *value = [keyValue[1] stringByRemovingPercentEncoding];
            parameters[key] = value;
        }
    }
    return parameters;
}

#pragma mark - Open protocol operation

- (void)openProtocol:(Protocol *)protocol
{
    [self openProtocol:protocol settingBlock:nil];
}

- (void)openProtocol:(Protocol *)protocol settingBlock:(JCNavigatorSettingBlock)block
{
    [self openProtocol:protocol settingBlock:block presented:NO];
}

- (void)openProtocol:(Protocol *)protocol settingBlock:(JCNavigatorSettingBlock)block presented:(BOOL)presented
{
    [self openProtocol:protocol settingBlock:block presented:presented animated:YES];
}

- (void)openProtocol:(Protocol *)protocol settingBlock:(JCNavigatorSettingBlock)block presented:(BOOL)presented animated:(BOOL)animated
{
    JCURLMap *URLMap = [self URLMapForProtocol:protocol];
    if (!URLMap) {
#ifdef DEBUG
        NSLog(@"Protocol %@ not found! Please implement the mapping relation of protocol and view controller in the subclass of JCURLMap, which should be added to JCNavigator with addURLMap: method.", NSStringFromProtocol(protocol));
#endif
        return;
    }
    UIViewController *viewController = nil;
    Class viewControllerClass = [URLMap viewControllerClassForProtocol:protocol];
    if ([[URLMap reuseViewControllerClasses] containsObject:viewControllerClass]) {
        viewController = [self existedViewControllerForClass:viewControllerClass];
        if (viewController) {
            if (block) {
                block(viewController);
            }
            [self openPreviousVCOfWillOpenedVC:viewController completion:^(BOOL success) {
                if (success) {
                    [self openViewController:viewController presented:presented animated:animated];
                }
            }];
            return;
        }
    }
    if (!viewController) {
        viewController = [[viewControllerClass alloc] init];
    }
    if (block) {
        block(viewController);
    }
    [self openViewController:viewController presented:presented animated:animated];
}

#pragma mark - Pop view controller operation

- (void)popViewControllerAnimated:(BOOL)animated
{
    [self.visibleViewController.navigationController popViewControllerAnimated:animated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [self.visibleViewController.navigationController popToRootViewControllerAnimated:animated];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.visibleViewController.navigationController popToViewController:viewController animated:animated];
}

#pragma mark - Dismiss view controller operation

- (void)dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self.visibleViewController dismissViewControllerAnimated:animated completion:^{
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - View controller getter and page jumps

- (UIViewController *)existedViewControllerForClass:(Class)class
{
    return [self existedViewControllerForClass:class navigationController:self.rootNavigationController];
}

- (UIViewController *)existedViewControllerForClass:(Class)class navigationController:(UINavigationController *)navigationController
{
    if (!class || !navigationController) {
        return nil;
    }
    UIViewController *viewController = nil;
    for (UIViewController *vc in navigationController.viewControllers) {
        if ([vc isMemberOfClass:class]) {
            viewController = vc;
            break;
        } else if (vc.presentedViewController && [vc.presentedViewController isKindOfClass:[UINavigationController class]]) {
            viewController = [self existedViewControllerForClass:class navigationController:(UINavigationController *)vc.presentedViewController];
            if (viewController) {
                break;
            }
        }
    }
    return viewController;
}

/// Pop to the previous view controller of viewController,
/// Or dismiss to the previous navigation level of viewController.
- (void)openPreviousVCOfWillOpenedVC:(UIViewController *)viewController completion:(void(^)(BOOL success))completion
{
    if (!viewController) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    NSArray *viewControllers = self.visibleViewController.navigationController.viewControllers;
    if ([viewControllers containsObject:viewController]) {
        NSUInteger vcIndex = [viewControllers indexOfObject:viewController];
        if (vcIndex > 0) {
            // pop to the previous view controller of viewController.
            [self popToViewController:viewControllers[vcIndex - 1] animated:NO];
            if (completion) {
                completion(YES);
            }
            return;
        } else if (viewController != self.rootViewController) {
            // dismiss to the previous navigation level of viewController.
            [self dismissViewControllerAnimated:NO completion:^{
                if (completion) {
                    completion(YES);
                }
            }];
            return;
        }
        if (completion) {
            completion(NO);
        }
        return;
    }
    if (self.visibleViewController != self.rootViewController) {
        // dismiss to the previous navigation level to find viewController.
        [self dismissViewControllerAnimated:NO completion:^{
            [self openPreviousVCOfWillOpenedVC:viewController completion:completion];
        }];
    } else {
        if (completion) {
            completion(NO);
        }
    }
}

/// Method of opening view controller.
- (void)openViewController:(UIViewController *)viewController presented:(BOOL)presented animated:(BOOL)animated
{
    if (presented) {
        if (self.dismissButtonBlock) {
            self.dismissButtonBlock(viewController);
        }
        UINavigationController *navigationController = [[self.navigationControllerClass alloc] initWithRootViewController:viewController];
        UIViewController *vc = self.visibleViewController.parentViewController ?: self.visibleViewController;
        [vc presentViewController:navigationController animated:animated completion:nil];
        return;
    }
    if (self.popButtonBlock) {
        self.popButtonBlock(viewController);
    }
    [self.visibleViewController.navigationController pushViewController:viewController animated:animated];
}

#pragma mark - URLMap

- (JCURLMap *)URLMapForProtocol:(Protocol *)protocol
{
    __block JCURLMap *URLMap = nil;
    [self.URLMaps enumerateObjectsUsingBlock:^(JCURLMap *map, BOOL *stop) {
        if ([map viewControllerClassForProtocol:protocol]) {
            URLMap = map;
            *stop = YES;
        }
    }];
    return URLMap;
}

- (JCURLMap *)URLMapForURL:(NSURL *)URL
{
    __block JCURLMap *URLMap = nil;
    [self.URLMaps enumerateObjectsUsingBlock:^(JCURLMap *map, BOOL *stop) {
        if ([map viewControllerClassForURL:URL]) {
            URLMap = map;
            *stop = YES;
        }
    }];
    return URLMap;
}

@end
