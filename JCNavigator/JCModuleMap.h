//
//  JCModuleMap.h
//  JCNavigator
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JCModuleMap <NSObject>

/**
 * Returns view controller class which conforms to the protocol.
 */
- (Class)viewControllerClassForProtocol:(Protocol *)protocol;

/**
 * Returns view controller class which relating to the URL.
 */
- (Class)viewControllerClassForURL:(NSURL *)URL;

@end

/**
 * Class of module map for pages jump.
 */
@interface JCModuleMap : NSObject <JCModuleMap>

/**
 * Global setting of protocol prefix, such as JC.
 */
+ (void)setProtocolPrefix:(NSString *)protocolPrefix;

#pragma mark - Implemented by subclass

/**
 * Returns dictionary with the map of classes and protocols.
 */
- (NSDictionary<NSString *,Class> *)classesForProtocols;

/**
 * Presented or not settings while opening the view controllers, default NO.
 */
- (BOOL)presentedForClass:(Class)viewControllerClass;

/**
 * Animated or not settings while opening the view controllers, default YES.
 */
- (BOOL)animatedForClass:(Class)viewControllerClass;

/**
 * Returns array of reuse view controller classes.
 * @note The view controllers of classes will be reused if existed in window, otherwise new view controllers will be created.
 */
- (NSArray *)reuseViewControllerClasses;

/**
 * Returns dictionary with properties map of URL query for classes.
 */
- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses;

@end
