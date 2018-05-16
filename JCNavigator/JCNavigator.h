//
//  JCNavigator.h
//  JCNavigator
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JCURLMap;

/**
 * Block of settings for will opened view controller.
 */
typedef void (^JCNavigatorSettingBlock)(UIViewController *willOpenedViewController);

/**
 * Class of navigation manager.
 */
@interface JCNavigator : NSObject

/**
 * Singleton instance of JCNavigator.
 */
+ (instancetype)sharedNavigator;

/**
 * Add customized NSURL scheme with host list which can be used for pages jump.
 * @param scheme customized NSURL scheme.
 * @param hostList customized list of NSURL host.
 */
- (void)addURLScheme:(NSString *)scheme hostList:(NSArray<NSString *> *)hostList;

/**
 * Add several modules of URL maps which subclassing from JCURLMap.
 */
- (void)addURLMap:(JCURLMap *)URLMap;

/**
 * Set class of navigation controller which subclassing from UINavigationController.
 */
- (void)setNavigationControllerClass:(Class)navigationControllerClass;

/**
 * Set the root view controller for the window.
 */
- (void)setRootViewController:(UIViewController *)rootViewController;

/**
 * The root navigation controller for the window.
 */
- (UINavigationController *)rootNavigationController;

/**
 * The top view controller on the stack.
 */
- (UIViewController *)topViewController;

/**
 * Current visible view controller.
 * @note Return modal view controller if it exists. Otherwise the top view controller.
 */
- (UIViewController *)visibleViewController;


#pragma mark - Open URL operation

/**
 * Open URL methods.
 * @note URL string format 'scheme://host/path?paramA=xxx&paramB=yyy'
 */
- (void)openURLString:(NSString *)URLString;
- (void)openURL:(NSURL *)URL;
- (void)openURL:(NSURL *)URL completionHandler:(void(^)(BOOL success))completionHandler;
- (void)openURL:(NSURL *)URL options:(NSDictionary *)options completionHandler:(void (^)(BOOL success))completionHandler;

#pragma mark - Open protocol operation

- (void)openProtocol:(Protocol *)protocol;
- (void)openProtocol:(Protocol *)protocol settingBlock:(JCNavigatorSettingBlock)block;
- (void)openProtocol:(Protocol *)protocol settingBlock:(JCNavigatorSettingBlock)block presented:(BOOL)presented;
- (void)openProtocol:(Protocol *)protocol settingBlock:(JCNavigatorSettingBlock)block presented:(BOOL)presented animated:(BOOL)animated;

#pragma mark - Pop view controller operation

- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

#pragma mark - Dismiss view controller operation

- (void)dismissViewController;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
