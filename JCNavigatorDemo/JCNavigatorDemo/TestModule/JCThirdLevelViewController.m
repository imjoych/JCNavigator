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
    self.view.backgroundColor = [UIColor whiteColor];
    
    JCTestView *view = [[JCTestView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) pushBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_firstLevel)];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_contentDetail) propertiesBlock:^NSDictionary *{
            return @{@"currentIndex": @"3",
                     @"testId": @"hahaha666",
                     @"testArray": @[@"hello", @"world", @"!"],
                     };
        } presented:YES];
    }];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
