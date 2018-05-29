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
 * Returns view controller class for map key which implemented in classesForMapKeys: method.
 */
- (Class)viewControllerClassForMapKey:(NSString *)mapKey;

/**
 * Returns view controller class for URL which lastPathComponent relating to the map key.
 */
- (Class)viewControllerClassForURL:(NSURL *)URL;

@end

/**
 * Class of module map for pages jump.
 */
@interface JCModuleMap : NSObject <JCModuleMap>

#pragma mark - Implemented by subclass

/**
 * Returns module map key prefix, default JC.
 */
- (NSString *)mapKeyPrefix;

/**
 * Returns dictionary with the map of classes for mapKeys.
 */
- (NSDictionary<NSString *,Class> *)classesForMapKeys;

/**
 * Presented or not settings while opening the view controllers through URL, default NO.
 */
- (BOOL)presentedForClass:(Class)viewControllerClass;

/**
 * Animated or not settings while opening the view controllers through URL, default YES.
 */
- (BOOL)animatedForClass:(Class)viewControllerClass;

/**
 * Returns array of reuse view controller classes.
 * @note The view controllers of classes will be reused if existed in window, otherwise new view controllers will be created.
 */
- (NSArray<Class> *)reuseViewControllerClasses;

/**
 * Returns dictionary with properties map of URL query for classes.
 */
- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses;

@end
