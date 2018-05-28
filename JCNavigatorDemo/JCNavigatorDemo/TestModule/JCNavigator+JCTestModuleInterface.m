//
//  JCNavigator+JCTestModuleInterface.m
//  JCNavigatorDemo
//
//  Created by jianjun16 on 2018/5/24.
//  Copyright © 2018年 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCNavigator+JCTestModuleInterface.h"

@implementation JCNavigator (JCTestModuleInterface)

+ (void)openFirstLevelViewController
{
    [[JCNavigator sharedNavigator] openProtocol:NSProtocolFromString(@"JC_firstLevel")];
}

+ (void)openSecondLevelViewController
{
    [[JCNavigator sharedNavigator] openProtocol:NSProtocolFromString(@"JC_secondLevel")];
}

+ (void)openThirdLevelViewController
{
    [[JCNavigator sharedNavigator] openProtocol:NSProtocolFromString(@"JC_thirdLevel")];
}

+ (void)openContentDetailViewControllerWithCurrentIndex:(NSString *)currentIndex testId:(NSString *)testId testArray:(NSArray *)testArray
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    if ([currentIndex isKindOfClass:[NSString class]]) {
        params[@"currentIndex"] = currentIndex;
    }
    if ([testId isKindOfClass:[NSString class]]) {
        params[@"testId"] = testId;
    }
    if ([testArray isKindOfClass:[NSArray class]]) {
        params[@"testArray"] = testArray;
    }
    [[JCNavigator sharedNavigator] openProtocol:NSProtocolFromString(@"JC_contentDetail") propertiesBlock:^NSDictionary *{
        return params;
    } presented:YES];
}

@end
