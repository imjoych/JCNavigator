//
//  JCTabBarController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2021/3/10.
//  Copyright © 2021 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCTabBarController.h"
#import "JCNavigationController.h"
#import "ViewController.h"
#import "JCFirstLevelViewController.h"

@interface JCTabBarController ()

@end

@implementation JCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTabBar];
}

- (void)configTabBar
{
    ViewController *homepageVC = [[ViewController alloc] init];
    homepageVC.title = @"Homepage";
    JCNavigationController *homepageNavi = [[JCNavigationController alloc] initWithRootViewController:homepageVC];
    
    JCFirstLevelViewController *firstLevelVC = [[JCFirstLevelViewController alloc] init];
    firstLevelVC.title = @"FirstLevel";
    JCNavigationController *firstLevelNavi = [[JCNavigationController alloc] initWithRootViewController:firstLevelVC];
    
    self.viewControllers = @[homepageNavi, firstLevelNavi];
}

@end
