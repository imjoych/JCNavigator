//
//  JCNavigator+JCTestModuleInterface.m
//  JCNavigatorDemo
//
//  Created by jianjun16 on 2018/5/24.
//  Copyright © 2018年 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCNavigator+JCTestModuleInterface.h"
#import "JCTestModuleMap.h"

@implementation JCNavigator (JCTestModuleInterface)

+ (void)load
{
    [[JCNavigator sharedNavigator] addModuleMap:[JCTestModuleMap new]];
}

+ (void)openFirstLevelViewController
{
    [[JCNavigator sharedNavigator] openWithMapKey:JCFirstLevelMapKey];
//    [[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/firstlevel"]];
//    [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.JCNavigatorDemo/firstlevel"];
}

+ (void)openSecondLevelViewController
{
    [[JCNavigator sharedNavigator] openWithMapKey:JCSecondLevelMapKey];
//    [[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/secondlevel"]];
//    [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.JCNavigatorDemo/secondlevel"];
}

+ (void)openThirdLevelViewController
{
    [[JCNavigator sharedNavigator] openWithMapKey:JCThirdLevelMapKey];
//    [[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/thirdlevel"]];
//    [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.JCNavigatorDemo/thirdlevel"];
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
    [[JCNavigator sharedNavigator] openWithMapKey:JCContentDetailMapKey propertiesBlock:^NSDictionary *{
        return params;
    } presented:YES];
}

@end
