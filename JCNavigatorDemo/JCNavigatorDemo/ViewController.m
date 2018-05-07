//
//  ViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "ViewController.h"
#import "JCCommonHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSStringFromClass([self class]);
    JCCommonView *view = [JCCommonView viewWithPushBlock:^{
        [[JCNavigator sharedNavigator] openScheme:@protocol(JC_firstLevel)];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openScheme:@protocol(JC_contentDetail) settingBlock:^(UIViewController<JC_contentDetail> *willOpenedViewController) {
            willOpenedViewController.currentIndex = @"0";
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
