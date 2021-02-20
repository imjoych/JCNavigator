//
//  JCThirdLevelViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCThirdLevelViewController.h"
#import "JCTestHeader.h"

@interface JCThirdLevelViewController ()

@property (nonatomic, strong) JCTestView *testView;

@end

@implementation JCThirdLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    _testView = [[JCTestView alloc] initWithFrame:CGRectZero pushBlock:^{
        [JCTestModuleMap openFirstLevelVCPresented:NO propertiesDict:@{@"comeFrom": @"Third Level"}];
    } presentBlock:^{
        [JCTestModuleMap openContentDetailVCWithCurrentIndex:@"3" testId:@"hahaha666" testArray:@[@"Hello", @"world", @"!"]];
    }];
    [self.view addSubview:_testView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.testView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
