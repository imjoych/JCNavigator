//
//  JCModuleMap.m
//  JCNavigator
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCModuleMap.h"

static NSString *JCProtocolPrefix = @"JC";

@interface JCModuleMap ()

@property (nonatomic, strong) NSDictionary *lowercaseStringMaps;

@end

@implementation JCModuleMap

+ (void)setProtocolPrefix:(NSString *)protocolPrefix
{
    JCProtocolPrefix = protocolPrefix;
}

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return nil;
}

- (id)instanceForClass:(Class)viewControllerClass
{
    return [[viewControllerClass alloc] init];
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
    NSDictionary *classesForProtocols = [self classesForProtocols];
    if (!classesForProtocols || classesForProtocols.count < 1) {
        return nil;
    }
    if (!_lowercaseStringMaps) {
        NSMutableDictionary *maps = [@{} mutableCopy];
        [classesForProtocols enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            maps[[key lowercaseString]] = obj;
        }];
        _lowercaseStringMaps = [maps copy];
    }
    return _lowercaseStringMaps;
}

#pragma mark - JCModuleMap protocol

- (Class)viewControllerClassForProtocol:(Protocol *)protocol
{
    NSString *protocolName = NSStringFromProtocol(protocol);
    protocolName = [protocolName lowercaseString];
    NSDictionary *maps = [self lowercaseStringMaps];
    if ([maps.allKeys containsObject:protocolName]) {
        return maps[protocolName];
    }
    return nil;
}

- (Class)viewControllerClassForURL:(NSURL *)URL
{
    NSString *protocolName = [NSString stringWithFormat:@"%@_%@", JCProtocolPrefix, [URL lastPathComponent]];
    protocolName = [protocolName lowercaseString];
    NSDictionary *maps = [self lowercaseStringMaps];
    if ([maps.allKeys containsObject:protocolName]) {
        return maps[protocolName];
    }
    return nil;
}

@end
