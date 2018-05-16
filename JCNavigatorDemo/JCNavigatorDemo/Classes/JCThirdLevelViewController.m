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

@end

@implementation JCThirdLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass([self class]);
    JCTestView *view = [JCTestView viewWithPushBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_firstLevel)];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_contentDetail) propertiesBlock:^NSDictionary *{
            JCTestClass *testClass = [JCTestClass new];
            testClass.testId = @"hahaha111";
            return @{@"currentIndex": @"3",
                     @"testArray": [NSNull null],
                     @"testClass": testClass,
                     };
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
