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
        [JCNavigator openSecondLevelViewController];
    } presentBlock:^{
        [JCNavigator openContentDetailViewControllerWithCurrentIndex:@"1" testId:nil testArray:nil];
//        [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.jcnavigatordemo/contentdetail?pageindex=1"];
    }];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
