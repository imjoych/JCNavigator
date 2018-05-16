//
//  JCSecondLevelViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCSecondLevelViewController.h"
#import "JCTestHeader.h"

@interface JCSecondLevelViewController ()

@end

@implementation JCSecondLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass([self class]);
    JCTestView *view = [JCTestView viewWithPushBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_thirdLevel)];
    } presentBlock:^{
        [self showAlert];
    }];
    [self.view addSubview:view];
    view.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Open ApplicationSettings or contentDetailViewController_2 ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[JCNavigator sharedNavigator] openURLString:UIApplicationOpenSettingsURLString];
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Detail" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_contentDetail) propertiesBlock:^NSDictionary *{
            return @{@"currentIndex": @"2"};
        } presented:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self.parentViewController presentViewController:alertController animated:YES completion:nil];
}

@end
