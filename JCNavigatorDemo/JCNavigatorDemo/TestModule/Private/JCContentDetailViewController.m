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

@property (nonatomic, strong) JCTestView *testView;

@end

@implementation JCContentDetailViewController
@synthesize currentIndex, testId, testArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), self.currentIndex];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _testView = [[JCTestView alloc] initWithFrame:CGRectZero pushBlock:^{
        if ([self.currentIndex integerValue] == 3) {
            [[JCNavigator sharedNavigator] dismissAndPopToRootViewControllerCompletion:nil];
            return;
        }
        [self openViewControllerPresented:NO];
    } presentBlock:^{
        [self openViewControllerPresented:YES];
    }];
    [_testView setTestObject:[self testObject]];
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

- (void)openViewControllerPresented:(BOOL)presented
{
    switch ([self.currentIndex integerValue]) {
        case 0:
            [JCTestModuleMap openFirstLevelVCPresented:presented propertiesDict:@{@"comeFrom": @"Root Detail"}];
            break;
        case 1:
            [JCTestModuleMap openSecondLevelVCPresented:presented];
            break;
        case 2:
            [JCTestModuleMap openThirdLevelVCPresented:presented];
            break;
        case 3:
            [JCTestModuleMap openFirstLevelVCPresented:presented propertiesDict:@{@"comeFrom": @"Third Level Detail"}];
            break;
        default:
            [JCTestModuleMap openFirstLevelVCPresented:presented propertiesDict:@{}];
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
