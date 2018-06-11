//
//  JCNavigator+JCRootModuleInterface.m
//  JCNavigatorDemo
//
//  Created by jianjun16 on 2018/6/11.
//  Copyright © 2018年 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCNavigator+JCRootModuleInterface.h"
#import "JCRootModuleMap.h"

@implementation JCNavigator (JCRootModuleInterface)

+ (void)load
{
    [[JCNavigator sharedNavigator] addModuleMap:[JCRootModuleMap new]];
}

@end
