//
//  JCFirstLevelViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCFirstLevelViewController.h"
#import "JCTestHeader.h"

@interface JCFirstLevelViewController ()

@end

@implementation JCFirstLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    JCTestView *view = [[JCTestView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) pushBlock:^{
//        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_secondLevel)];
        [[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/secondlevel"]];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.jcnavigatordemo/contentdetail?pageindex=1"];
//        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_contentDetail) propertiesBlock:^NSDictionary *{
//            return @{@"currentIndex": @"1"};
//        } presented:YES];
    }];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
