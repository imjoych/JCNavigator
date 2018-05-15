//
//  JCThirdLevelViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCThirdLevelViewController.h"
#import "JCCommonHeader.h"

@interface JCThirdLevelViewController ()

@end

@implementation JCThirdLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass([self class]);
    JCCommonView *view = [JCCommonView viewWithPushBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_firstLevel)];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_contentDetail) settingBlock:^(UIViewController<JC_contentDetail> *willOpenedViewController) {
            willOpenedViewController.currentIndex = @"3";
        } presented:YES];
    }];
    [self.view addSubview:view];
    view.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
