//
//  ViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "ViewController.h"
#import "JCNavigator.h"
#import "JCRootView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    JCRootView *view = [[JCRootView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) pushBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:NSProtocolFromString(@"JC_firstLevel")];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:NSProtocolFromString(@"JC_contentDetail") propertiesBlock:^NSDictionary *{
            return @{@"currentIndex": @"0"};
        } presented:YES];
    }];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
