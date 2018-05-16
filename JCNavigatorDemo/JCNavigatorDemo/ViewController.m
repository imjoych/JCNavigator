//
//  ViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "ViewController.h"
#import "JCTestHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSStringFromClass([self class]);
    JCTestView *view = [JCTestView viewWithPushBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_firstLevel)];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:@protocol(JC_contentDetail) propertiesBlock:^NSDictionary *{
            return @{@"currentIndex": @"0"};
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
