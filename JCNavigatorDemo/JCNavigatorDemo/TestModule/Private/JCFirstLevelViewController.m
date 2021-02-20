//
//  JCFirstLevelViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCFirstLevelViewController.h"
#import "JCTestHeader.h"
#import "JCTestClass.h"

@interface JCFirstLevelViewController ()

@property (nonatomic, strong) JCTestView *testView;

@end

@implementation JCFirstLevelViewController
@synthesize comeFrom = _comeFrom;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    _testView = [[JCTestView alloc] initWithFrame:CGRectZero pushBlock:^{
        [JCTestModuleMap openSecondLevelVCPresented:NO];
    } presentBlock:^{
        [JCTestModuleMap openContentDetailVCWithCurrentIndex:@"1" testId:nil testArray:nil];
//        [[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.jcnavigatordemo/contentdetail?pageindex=1"];
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

- (void)setComeFrom:(NSString *)comeFrom
{
    _comeFrom = comeFrom;
    [self.testView setTestObject:[self testObject]];
}

- (JCTestClass *)testObject
{
    JCTestClass *testObject = [JCTestClass new];
    testObject.testId = @"FirstLevel";
    testObject.testArray = @[@"come", @"from", self.comeFrom ?:@"Mars!"];
    return testObject;
}

@end
