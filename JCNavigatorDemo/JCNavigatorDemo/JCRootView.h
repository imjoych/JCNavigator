//
//  JCRootView.h
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/17.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCRootView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    pushBlock:(void(^)(void))pushBlock
                 presentBlock:(void(^)(void))presentBlock;

@end
