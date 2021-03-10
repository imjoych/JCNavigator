//
//  UIViewController+JCNavigationItem.h
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JCNavigationItem)

- (UIButton *)jc_setupLeftBackBarButtonItem;

- (UIButton *)jc_setupLeftCloseBarButtonItem;

- (void)jc_leftBackButtonPressed:(id)sender;

- (void)jc_leftCloseButtonPressed:(id)sender;

@end
