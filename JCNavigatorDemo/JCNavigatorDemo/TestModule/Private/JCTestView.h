//
//  JCTestView.h
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCTestClass;

@interface JCTestView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    pushBlock:(void(^)(void))pushBlock
                 presentBlock:(void(^)(void))presentBlock;

- (void)setTestObject:(JCTestClass *)testObject;

@end
