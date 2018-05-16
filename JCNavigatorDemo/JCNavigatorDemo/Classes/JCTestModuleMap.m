//
//  JCTestModuleMap.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCTestModuleMap.h"

@implementation JCTestModuleMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{@"JC_firstLevel": NSClassFromString(@"JCFirstLevelViewController"),
             @"JC_secondLevel": NSClassFromString(@"JCSecondLevelViewController"),
             @"JC_thirdLevel": NSClassFromString(@"JCThirdLevelViewController"),
             @"JC_contentDetail": NSClassFromString(@"JCContentDetailViewController"),
             };
}

- (BOOL)presentedForClass:(Class)viewControllerClass
{
    if ([viewControllerClass isEqual:NSClassFromString(@"JCContentDetailViewController")]) {
        return YES;
    }
    return NO;
}

- (NSArray *)reuseViewControllerClasses
{
    return @[NSClassFromString(@"JCFirstLevelViewController")];
}

- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses
{
    return @{@"JCContentDetailViewController": @{@"pageindex": @"currentIndex"}};
}

@end
