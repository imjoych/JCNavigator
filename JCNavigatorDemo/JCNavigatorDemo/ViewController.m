//
//  ViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "ViewController.h"
#import "JCTestModuleMap.h"
#import "JCRootView.h"

@interface ViewController ()

@property (nonatomic, strong) JCRootView *rootView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    _rootView = [[JCRootView alloc] initWithFrame:CGRectZero pushBlock:^{
        [JCTestModuleMap openFirstLevelVCPresented:NO propertiesDict:@{@"comeFrom": @"Root"}];
    } presentBlock:^{
        [JCTestModuleMap openContentDetailVCWithCurrentIndex:@"0" testId:nil testArray:nil];
    }];
    [self.view addSubview:_rootView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.rootView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
