//
//  JCTestModuleMap.h
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCModuleMap.h"

@interface JCTestModuleMap : JCModuleMap

+ (void)openFirstLevelVCPresented:(BOOL)presented
                   propertiesDict:(NSDictionary *)propertiesDict;

+ (void)openSecondLevelVCPresented:(BOOL)presented;

+ (void)openThirdLevelVCPresented:(BOOL)presented;

+ (void)openContentDetailVCWithCurrentIndex:(NSString *)currentIndex
                                     testId:(NSString *)testId
                                  testArray:(NSArray *)testArray;

@end
