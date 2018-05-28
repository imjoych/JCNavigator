//
//  JCNavigator+JCTestModuleInterface.h
//  JCNavigatorDemo
//
//  Created by jianjun16 on 2018/5/24.
//  Copyright © 2018年 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCNavigator.h"

@interface JCNavigator (JCTestModuleInterface)

+ (void)openFirstLevelViewController;

+ (void)openSecondLevelViewController;

+ (void)openThirdLevelViewController;

+ (void)openContentDetailViewControllerWithCurrentIndex:(NSString *)currentIndex
                                                 testId:(NSString *)testId
                                              testArray:(NSArray *)testArray;

@end
