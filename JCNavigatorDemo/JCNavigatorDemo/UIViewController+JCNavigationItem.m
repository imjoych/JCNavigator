//
//  UIViewController+JCNavigationItem.m
//  JCNavigatorDemo
//
//  Created by jianjun16 on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "UIViewController+JCNavigationItem.h"
#import "JCNavigator.h"

@implementation UIViewController (JCNavigationItem)

- (UIButton *)jc_setupLeftBackBarButtonItem
{
    UIButton *button = [self buttonWithTitle:nil
                                       image:[UIImage imageNamed:@"icon_back"]
                            highLightedImage:[UIImage imageNamed:@"icon_back"]];
    [button addTarget:self
               action:@selector(jc_leftBackButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 40, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
}

- (UIButton *)jc_setupLeftCloseBarButtonItem
{
    UIButton *button = [self buttonWithTitle:nil
                                       image:[UIImage imageNamed:@"icon_close"]
                            highLightedImage:[UIImage imageNamed:@"icon_close"]];
    [button addTarget:self
               action:@selector(jc_leftCloseButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 40, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
}

- (void)jc_leftBackButtonPressed:(id)sender
{
    [[JCNavigator sharedNavigator] popViewControllerAnimated:YES];
}

- (void)jc_leftCloseButtonPressed:(id)sender
{
    [[JCNavigator sharedNavigator] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (UIButton *)buttonWithTitle:(NSString *)title
                        image:(UIImage *)image
             highLightedImage:(UIImage *)highLightedImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (title.length > 0) {
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7f] forState:UIControlStateDisabled];
        button.frame = CGRectMake(0, 0, title.length * 16 + 8, 28);
    }
    if (image) {
        if (!highLightedImage) {
            highLightedImage = image;
        }
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:highLightedImage forState:UIControlStateHighlighted];
        [button sizeToFit];
    }
    return button;
}

@end
