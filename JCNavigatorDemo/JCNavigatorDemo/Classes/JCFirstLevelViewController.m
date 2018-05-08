//
//  JCFirstLevelViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCFirstLevelViewController.h"
#import "JCCommonHeader.h"

@interface JCFirstLevelViewController ()

@end

@implementation JCFirstLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass([self class]);
    JCCommonView *view = [JCCommonView viewWithPushBlock:^{
//        [[JCNavigator sharedNavigator] openScheme:@protocol(JC_secondLevel)];
        [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.JCNavigatorDemo/secondlevel"];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.jcnavigatordemo/contentdetail?pageindex=1"];
//        [[JCNavigator sharedNavigator] openScheme:@protocol(JC_contentDetail) settingBlock:^(UIViewController<JC_contentDetail> *willOpenedViewController) {
//            willOpenedViewController.currentIndex = @"1";
//        } presented:YES];
    }];
    [view resetPresentTitle:@"PushDetailViewController"];
    [self.view addSubview:view];
    view.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
