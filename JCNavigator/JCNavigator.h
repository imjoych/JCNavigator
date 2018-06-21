//
//  JCNavigator.h
//  JCNavigator
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JCModuleMap;

/**
 * Values for properties will be setted for will opened view controller with this block.
 */
typedef NSDictionary *(^JCNavigatorPropertiesBlock)(void);

/**
 * Class of navigation manager.
 */
@interface JCNavigator : NSObject

/**
 * Singleton instance of JCNavigator.
 */
+ (instancetype)sharedNavigator;

/**
 * Add customized NSURL scheme with host list which can be used for pages jump with open URL methods.
 * @param scheme customized NSURL scheme.
 * @param hostList customized list of NSURL host.
 */
- (void)addURLScheme:(NSString *)scheme hostList:(NSArray<NSString *> *)hostList;

/**
 * Add several modules of maps which subclassing from JCModuleMap.
 */
- (void)addModuleMap:(JCModuleMap *)moduleMap;

/**
 * Set the root view controller for the window.
 */
- (void)setRootViewController:(UIViewController *)rootViewController;

/**
 * Set class of navigation controller which subclassing from UINavigationController.
 */
- (void)setNavigationControllerClass:(Class)navigationControllerClass;

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
- (BOOL)openURLString:(NSString *)URLString;
- (BOOL)openURL:(NSURL *)URL;
- (BOOL)openURL:(NSURL *)URL options:(NSDictionary *)options;

#pragma mark - Open with module map key operation

- (void)openWithMapKey:(NSString *)mapKey;
- (void)openWithMapKey:(NSString *)mapKey propertiesBlock:(JCNavigatorPropertiesBlock)block;
- (void)openWithMapKey:(NSString *)mapKey propertiesBlock:(JCNavigatorPropertiesBlock)block presented:(BOOL)presented;
- (void)openWithMapKey:(NSString *)mapKey propertiesBlock:(JCNavigatorPropertiesBlock)block presented:(BOOL)presented animated:(BOOL)animated;

#pragma mark - Pop view controller operation

- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

#pragma mark - Dismiss view controller operation

- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
