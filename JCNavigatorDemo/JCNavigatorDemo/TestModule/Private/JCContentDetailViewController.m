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
#import "JCTestModuleMap.h"

@interface JCContentDetailViewController ()

@end

@implementation JCContentDetailViewController
@synthesize currentIndex, testId, testArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), self.currentIndex];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *mapKey = [self nextOpenMapKeyWithIndex:self.currentIndex];
    JCTestView *view = [[JCTestView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) pushBlock:^{
        [[JCNavigator sharedNavigator] openWithMapKey:mapKey];
    } presentBlock:^{
        [[JCNavigator sharedNavigator] openWithMapKey:mapKey propertiesBlock:nil presented:YES];
    }];
    [view setTestObject:[self testObject]];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)nextOpenMapKeyWithIndex:(NSString *)index
{
    switch ([index integerValue]) {
        case 0:
            return JCFirstLevelMapKey;
        case 1:
            return JCSecondLevelMapKey;
        case 2:
            return JCThirdLevelMapKey;
        case 3:
        default:
            return JCFirstLevelMapKey;
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
