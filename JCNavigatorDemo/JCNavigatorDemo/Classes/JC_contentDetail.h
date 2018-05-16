//
//  JC_contentDetail.h
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCTestClass.h"

@protocol JC_contentDetail <NSObject>

@property (nonatomic, strong) NSString *currentIndex;
@property (nonatomic, strong) NSArray *testArray;
@property (nonatomic, strong) JCTestClass *testClass;

@end
