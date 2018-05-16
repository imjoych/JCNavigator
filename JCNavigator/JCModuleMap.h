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
 * Returns instance of view controller class.
 */
- (id)instanceForClass:(Class)viewControllerClass;

/**
 * Returns default settings of will opened view controllers which presented or not.
 */
- (BOOL)presentedForClass:(Class)viewControllerClass;

/**
 * Returns default settings of will opened view controllers which animated or not.
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
