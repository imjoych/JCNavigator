//
//  JCTestModuleMap.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCTestModuleMap.h"
#import "JC_firstLevel.h"
#import "JC_secondLevel.h"
#import "JC_thirdLevel.h"
#import "JC_contentDetail.h"
#import "JCFirstLevelViewController.h"
#import "JCSecondLevelViewController.h"
#import "JCThirdLevelViewController.h"
#import "JCContentDetailViewController.h"

@implementation JCTestModuleMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{NSStringFromProtocol(@protocol(JC_firstLevel)): [JCFirstLevelViewController class],
             NSStringFromProtocol(@protocol(JC_secondLevel)): [JCSecondLevelViewController class],
             NSStringFromProtocol(@protocol(JC_thirdLevel)): [JCThirdLevelViewController class],
             NSStringFromProtocol(@protocol(JC_contentDetail)): [JCContentDetailViewController class],
             };
}

- (NSArray *)reuseViewControllerClasses
{
    return @[[JCFirstLevelViewController class]];
}

- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses
{
    return @{NSStringFromClass([JCContentDetailViewController class]): @{@"pageindex": @"currentIndex"}};
}

@end
