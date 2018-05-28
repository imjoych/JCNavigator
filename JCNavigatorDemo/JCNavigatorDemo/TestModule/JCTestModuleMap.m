//
//  JCTestModuleMap.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCTestModuleMap.h"

NSString *const JCFirstLevelMapKey = @"JC_firstLevel";
NSString *const JCSecondLevelMapKey = @"JC_secondLevel";
NSString *const JCThirdLevelMapKey = @"JC_thirdLevel";
NSString *const JCContentDetailMapKey = @"JC_contentDetail";

@implementation JCTestModuleMap

- (NSDictionary<NSString *,Class> *)classesForMapKeys
{
    return @{JCFirstLevelMapKey: NSClassFromString(@"JCFirstLevelViewController"),
             JCSecondLevelMapKey: NSClassFromString(@"JCSecondLevelViewController"),
             JCThirdLevelMapKey: NSClassFromString(@"JCThirdLevelViewController"),
             JCContentDetailMapKey: NSClassFromString(@"JCContentDetailViewController"),
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
