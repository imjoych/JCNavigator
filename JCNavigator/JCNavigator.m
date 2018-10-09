//
//  JCNavigator.m
//  JCNavigator
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCNavigator.h"
#import "JCModuleMap.h"

@interface JCNavigator () {
    NSMutableSet *_moduleMaps;
    NSMutableDictionary *_hostListForScheme;
    Class _navigationControllerClass;
    UIViewController *_rootViewController;
    UINavigationController *_rootNavigationController;
}

@end

@implementation JCNavigator

- (instancetype)init
{
    if (self = [super init]) {
        _moduleMaps = [NSMutableSet set];
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
    _hostListForScheme[[scheme lowercaseString]] = [lowercaseHostList copy];
}

- (void)addModuleMap:(JCModuleMap *)moduleMap
{
    [_moduleMaps addObject:moduleMap];
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    _rootViewController = rootViewController;
    if ([rootViewController isKindOfClass:_navigationControllerClass]) {
        _rootNavigationController = (UINavigationController *)rootViewController;
    } else {
        _rootNavigationController = [[_navigationControllerClass alloc] initWithRootViewController:rootViewController];
    }
    [UIApplication sharedApplication].delegate.window.rootViewController = _rootNavigationController;
}

- (void)setNavigationControllerClass:(Class)navigationControllerClass
{
    _navigationControllerClass = navigationControllerClass;
}

- (UINavigationController *)rootNavigationController
{
    return _rootNavigationController;
}

- (UIViewController *)topViewController
{
    return _rootNavigationController.topViewController;
}

- (UIViewController *)visibleViewController
{
    return _rootNavigationController.visibleViewController;
}

#pragma mark - Open URL operation

- (BOOL)openURLString:(NSString *)URLString
{
    if (![URLString isKindOfClass:[NSString class]]) {
        return NO;
    }
    return [self openURL:[NSURL URLWithString:URLString]];
}

- (BOOL)openURL:(NSURL *)URL
{
    return [self openURL:URL options:nil];
}

- (BOOL)openURL:(NSURL *)URL options:(NSDictionary *)options
{
    if (![URL isKindOfClass:[NSURL class]] || !URL.scheme) { // Invalid URL.
        return NO;
    }
    
    NSString *lowercaseScheme = [URL.scheme lowercaseString];
    if (![_hostListForScheme.allKeys containsObject:lowercaseScheme] || !URL.host) { // URL scheme not found or URL host not exist.
        return [self openSpecifiedURL:URL options:options];
    }
    
    NSArray *hostList = _hostListForScheme[lowercaseScheme];
    NSString *lowercaseHost = [URL.host lowercaseString];
    if (![hostList containsObject:lowercaseHost]) { // URL host not found.
        return [self openSpecifiedURL:URL options:options];
    }
    
    JCModuleMap *moduleMap = [self moduleMapForURL:URL];
    if (!moduleMap) { // The corresponding moduleMap not found.
        return [self openSpecifiedURL:URL options:options];
    }
    
    Class viewControllerClass = [moduleMap viewControllerClassForURL:URL];
    NSDictionary *parameters = [self parseURLQuery:URL.query];
    BOOL presented = [moduleMap presentedForClass:viewControllerClass];
    BOOL animated = [moduleMap animatedForClass:viewControllerClass];
    [self openViewControllerWithClass:viewControllerClass
                            moduleMap:moduleMap
                               params:parameters
                            presented:presented
                             animated:animated];
    return YES;
}

- (BOOL)openSpecifiedURL:(NSURL *)URL options:(NSDictionary *)options
{
    if (![URL isKindOfClass:[NSURL class]] || ![[UIApplication sharedApplication] canOpenURL:URL]) {
        return NO;
    }
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL options:options completionHandler:nil];
        return YES;
    }
    return [[UIApplication sharedApplication] openURL:URL];
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

#pragma mark - Open with module map key operation

- (void)openWithMapKey:(NSString *)mapKey
{
    [self openWithMapKey:mapKey propertiesBlock:nil];
}

- (void)openWithMapKey:(NSString *)mapKey propertiesBlock:(JCNavigatorPropertiesBlock)block
{
    [self openWithMapKey:mapKey propertiesBlock:block presented:NO animated:YES];
}

- (void)openWithMapKey:(NSString *)mapKey propertiesBlock:(JCNavigatorPropertiesBlock)block presented:(BOOL)presented animated:(BOOL)animated
{
    NSParameterAssert([mapKey isKindOfClass:[NSString class]]);
    JCModuleMap *moduleMap = [self moduleMapForMapKey:mapKey];
    if (!moduleMap) {
        NSAssert(moduleMap, @"The subclass of JCModuleMap for %@ not found! Please create it and implement the classesForMapKeys: method, next add it's instance to JCNavigator with addModuleMap: method.", mapKey);
        return;
    }
    Class viewControllerClass = [moduleMap viewControllerClassForMapKey:mapKey];
    NSDictionary *parameters = block ? block(): nil;
    [self openViewControllerWithClass:viewControllerClass
                            moduleMap:moduleMap
                               params:parameters
                            presented:presented
                             animated:animated];
}

#pragma mark - Pop view controller operation

- (void)popViewControllerAnimated:(BOOL)animated
{
    [[self visibleViewController].navigationController popViewControllerAnimated:animated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [[self visibleViewController].navigationController popToRootViewControllerAnimated:animated];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[self visibleViewController].navigationController popToViewController:viewController animated:animated];
}

#pragma mark - Dismiss view controller operation

- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [[self visibleViewController] dismissViewControllerAnimated:animated completion:^{
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - Open view controller

- (void)openViewControllerWithClass:(Class)viewControllerClass moduleMap:(JCModuleMap *)moduleMap params:(NSDictionary *)params presented:(BOOL)presented animated:(BOOL)animated
{
    NSParameterAssert([viewControllerClass isSubclassOfClass:[UIViewController class]]);
    if ([[moduleMap reuseViewControllerClasses] containsObject:viewControllerClass]) {
        UIViewController *viewController = [self existedViewControllerForClass:viewControllerClass];
        if (viewController) {
            [self setViewController:viewController moduleMap:moduleMap params:params];
            [self openPreviousVCOfWillOpenedVC:viewController completion:^(BOOL success) {
                if (success) {
                    [self openViewController:viewController presented:presented animated:animated];
                }
            }];
            return;
        }
    }
    
    UIViewController *viewController = [[viewControllerClass alloc] init];
    [self setViewController:viewController moduleMap:moduleMap params:params];
    [self openViewController:viewController presented:presented animated:animated];
}

- (UIViewController *)existedViewControllerForClass:(Class)class
{
    return [self existedViewControllerForClass:class navigationController:_rootNavigationController];
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

- (void)setViewController:(UIViewController *)viewController moduleMap:(JCModuleMap *)moduleMap params:(NSDictionary *)params
{
    if (![params isKindOfClass:[NSDictionary class]] || params.count < 1) {
        return;
    }
    NSDictionary *mapForClasses = [moduleMap propertiesMapOfURLQueryForClasses];
    NSDictionary *propertiesMap = mapForClasses[NSStringFromClass([viewController class])];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *propertyName = nil;
        if (propertiesMap) {
            propertyName = propertiesMap[key];
        }
        if (!propertyName) {
            propertyName = key;
        }
        NSString *propertySetterName = [NSString stringWithFormat:@"set%@%@:", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
        
        if (![obj isKindOfClass:[NSNull class]]
            && [viewController respondsToSelector:NSSelectorFromString(propertyName)]
            && [viewController respondsToSelector:NSSelectorFromString(propertySetterName)]) {
            [viewController setValue:obj forKey:propertyName];
        }
    }];
}

/// Pop to the previous view controller of viewController,
/// or dismiss to the previous navigation level of viewController.
- (void)openPreviousVCOfWillOpenedVC:(UIViewController *)viewController completion:(void(^)(BOOL success))completion
{
    if (!viewController) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    NSArray *viewControllers = [self visibleViewController].navigationController.viewControllers;
    if ([viewControllers containsObject:viewController]) {
        NSUInteger vcIndex = [viewControllers indexOfObject:viewController];
        if (vcIndex > 0) {
            // pop to the previous view controller of viewController.
            [self popToViewController:viewControllers[vcIndex - 1] animated:NO];
            if (completion) {
                completion(YES);
            }
            return;
        } else if (viewController != _rootViewController) {
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
    if ([self visibleViewController] != _rootViewController) {
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
        UINavigationController *navigationController = [[_navigationControllerClass alloc] initWithRootViewController:viewController];
        UIViewController *vc = [self visibleViewController].parentViewController ?: [self visibleViewController];
        [vc presentViewController:navigationController animated:animated completion:nil];
        return;
    }
    [[self visibleViewController].navigationController pushViewController:viewController animated:animated];
}

#pragma mark - ModuleMap

- (JCModuleMap *)moduleMapForMapKey:(NSString *)mapKey
{
    __block JCModuleMap *moduleMap = nil;
    [_moduleMaps enumerateObjectsUsingBlock:^(JCModuleMap *map, BOOL *stop) {
        if ([map viewControllerClassForMapKey:mapKey]) {
            moduleMap = map;
            *stop = YES;
        }
    }];
    return moduleMap;
}

- (JCModuleMap *)moduleMapForURL:(NSURL *)URL
{
    __block JCModuleMap *moduleMap = nil;
    [_moduleMaps enumerateObjectsUsingBlock:^(JCModuleMap *map, BOOL *stop) {
        if ([map viewControllerClassForURL:URL]) {
            moduleMap = map;
            *stop = YES;
        }
    }];
    return moduleMap;
}

@end
