//
//  JCModuleMap.m
//  JCNavigator
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCModuleMap.h"

static NSString *JCMapKeyPrefix = @"JC";

@interface JCModuleMap ()

@property (nonatomic, strong) NSDictionary *lowercaseStringMaps;

@end

@implementation JCModuleMap

+ (void)setMapKeyPrefix:(NSString *)mapKeyPrefix
{
    JCMapKeyPrefix = mapKeyPrefix;
}

- (NSDictionary<NSString *,Class> *)classesForMapKeys
{
    return nil;
}

- (BOOL)presentedForClass:(Class)viewControllerClass
{
    return NO;
}

- (BOOL)animatedForClass:(Class)viewControllerClass
{
    return YES;
}

- (NSArray *)reuseViewControllerClasses
{
    return nil;
}

- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses
{
    return nil;
}

- (NSDictionary *)lowercaseStringMaps
{
    NSDictionary *classesForMapKeys = [self classesForMapKeys];
    if (!classesForMapKeys || classesForMapKeys.count < 1) {
        return nil;
    }
    if (!_lowercaseStringMaps) {
        NSMutableDictionary *maps = [@{} mutableCopy];
        [classesForMapKeys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            maps[[key lowercaseString]] = obj;
        }];
        _lowercaseStringMaps = [maps copy];
    }
    return _lowercaseStringMaps;
}

#pragma mark - JCModuleMap protocol

- (Class)viewControllerClassForMapKey:(NSString *)mapKey
{
    if (![mapKey isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSString *lowercaseKey = [mapKey lowercaseString];
    NSDictionary *maps = [self lowercaseStringMaps];
    if ([maps.allKeys containsObject:lowercaseKey]) {
        return maps[lowercaseKey];
    }
    return nil;
}

- (Class)viewControllerClassForURL:(NSURL *)URL
{
    if (![URL isKindOfClass:[NSURL class]]) {
        return nil;
    }
    NSString *lowercaseKey = [NSString stringWithFormat:@"%@_%@", JCMapKeyPrefix, [URL lastPathComponent]];
    return [self viewControllerClassForMapKey:lowercaseKey];
}

@end
