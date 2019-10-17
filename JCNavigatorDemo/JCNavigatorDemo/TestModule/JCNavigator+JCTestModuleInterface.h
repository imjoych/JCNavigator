//
//  JCNavigator+JCTestModuleInterface.h
//  JCNavigatorDemo
//
//  Created by jianjun16 on 2018/5/24.
//  Copyright © 2018年 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCNavigator.h"

@interface JCNavigator (JCTestModuleInterface)

+ (void)openFirstLevelVCPresented:(BOOL)presented
                   propertiesDict:(NSDictionary *)propertiesDict;

+ (void)openSecondLevelVCPresented:(BOOL)presented;

+ (void)openThirdLevelVCPresented:(BOOL)presented;

+ (void)openContentDetailViewControllerWithCurrentIndex:(NSString *)currentIndex
                                                 testId:(NSString *)testId
                                              testArray:(NSArray *)testArray;

@end
