//
//  JCTestModuleMap.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCTestModuleMap.h"
#import "JCNavigator.h"

static NSString *const JCFirstLevelMapKey = @"JC_firstLevel";
static NSString *const JCSecondLevelMapKey = @"JC_secondLevel";
static NSString *const JCThirdLevelMapKey = @"JC_thirdLevel";
static NSString *const JCContentDetailMapKey = @"JC_contentDetail";

@implementation JCTestModuleMap

+ (void)initialize
{
    [[JCNavigator sharedNavigator] addModuleMap:[JCTestModuleMap new]];
}

+ (void)openFirstLevelVCPresented:(BOOL)presented propertiesDict:(NSDictionary *)propertiesDict
{
    if (presented) {
        [[JCNavigator sharedNavigator] openWithMapKey:JCFirstLevelMapKey propertiesBlock:^NSDictionary *{
            return propertiesDict;
        } presented:YES animated:YES];
        return;
    }
    [[JCNavigator sharedNavigator] openWithMapKey:JCFirstLevelMapKey propertiesBlock:^NSDictionary *{
        return propertiesDict;
    }];
//    [[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/firstlevel"]];
//    [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.JCNavigatorDemo/firstlevel"];
}

+ (void)openSecondLevelVCPresented:(BOOL)presented
{
    if (presented) {
        [[JCNavigator sharedNavigator] openWithMapKey:JCSecondLevelMapKey propertiesBlock:nil presented:YES animated:YES];
        return;
    }
    [[JCNavigator sharedNavigator] openWithMapKey:JCSecondLevelMapKey];
//    [[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/secondlevel"]];
//    [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.JCNavigatorDemo/secondlevel"];
}

+ (void)openThirdLevelVCPresented:(BOOL)presented
{
    if (presented) {
        [[JCNavigator sharedNavigator] openWithMapKey:JCThirdLevelMapKey propertiesBlock:nil presented:YES animated:YES];
        return;
    }
    [[JCNavigator sharedNavigator] openWithMapKey:JCThirdLevelMapKey];
//    [[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/thirdlevel"]];
//    [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.JCNavigatorDemo/thirdlevel"];
}

+ (void)openContentDetailVCWithCurrentIndex:(NSString *)currentIndex testId:(NSString *)testId testArray:(NSArray *)testArray
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
    } presented:YES animated:YES];
}

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

- (NSArray<Class> *)reuseViewControllerClasses
{
    return @[NSClassFromString(@"JCFirstLevelViewController")];
}

- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses
{
    return @{@"JCContentDetailViewController": @{@"pageindex": @"currentIndex"}};
}

@end
