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
    
    Protocol *protocol = [self nextOpenProtocolWithIndex:self.currentIndex];
    JCTestView *view = [[JCTestView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) pushBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:protocol];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openProtocol:protocol propertiesBlock:nil presented:YES];
    }];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Protocol *)nextOpenProtocolWithIndex:(NSString *)index
{
    switch ([index integerValue]) {
        case 0:
            return @protocol(JC_firstLevel);
        case 1:
            return @protocol(JC_secondLevel);
        case 2:
            return @protocol(JC_thirdLevel);
        case 3:
        default:
            return @protocol(JC_firstLevel);
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
