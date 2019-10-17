//
//  JCContentDetailViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCContentDetailViewController.h"
#import "JCTestHeader.h"
#import "JCTestClass.h"

@interface JCContentDetailViewController ()

@end

@implementation JCContentDetailViewController
@synthesize currentIndex, testId, testArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), self.currentIndex];
    self.view.backgroundColor = [UIColor whiteColor];
    
    JCTestView *view = [[JCTestView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) pushBlock:^{
        if ([self.currentIndex integerValue] == 3) {
            [[JCNavigator sharedNavigator] dismissAndPopToRootViewControllerCompletion:nil];
            return;
        }
        [self openViewControllerPresented:NO];
    } presentBlock:^{
        [self openViewControllerPresented:YES];
    }];
    [view setTestObject:[self testObject]];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openViewControllerPresented:(BOOL)presented
{
    switch ([self.currentIndex integerValue]) {
        case 0:
            [JCNavigator openFirstLevelVCPresented:presented];
            break;
        case 1:
            [JCNavigator openSecondLevelVCPresented:presented];
            break;
        case 2:
            [JCNavigator openThirdLevelVCPresented:presented];
            break;
        case 3:
        default:
            [JCNavigator openFirstLevelVCPresented:presented];
            break;
    }
}

- (JCTestClass *)testObject
{
    JCTestClass *testObject = nil;
    if (self.testId || self.testArray) {
        testObject = [JCTestClass new];
        testObject.testId = self.testId;
        testObject.testArray = self.testArray;
    }
    return testObject;
}

@end
