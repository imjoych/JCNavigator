//
//  JCNavigationController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCNavigationController.h"
#import "UIViewController+JCNavigationItem.h"

@interface JCNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation JCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        [viewController jc_setupLeftBackBarButtonItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    if ([viewControllerToPresent isKindOfClass:[UINavigationController class]]) {
        [[(UINavigationController *)viewControllerToPresent visibleViewController] jc_setupLeftCloseBarButtonItem];
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (BOOL)canPopViewController
{
    return self.viewControllers.count > 1;
}

- (BOOL)popGestureEnabled
{
    return !self.popGestureDisabled && [self canPopViewController];
}

//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.enabled = [self popGestureEnabled];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return [self popGestureEnabled];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
