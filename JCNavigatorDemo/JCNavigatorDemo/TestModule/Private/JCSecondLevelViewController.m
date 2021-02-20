//
//  JCSecondLevelViewController.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCSecondLevelViewController.h"
#import "JCTestHeader.h"

@interface JCSecondLevelViewController ()

@property (nonatomic, strong) UIImage *navigationBarBGImage;

@end

@implementation JCSecondLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    JCTestView *view = [[JCTestView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) pushBlock:^{
        [JCTestModuleMap openThirdLevelVCPresented:NO];
    } presentBlock:^{
        [self showAlert];
    }];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationBarBGImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    UIImage *image = [self createImageWithColor:[[UIColor blueColor] colorWithAlphaComponent:0.6]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:self.navigationBarBGImage forBarMetrics:UIBarMetricsDefault];
}

- (void)showAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Open ApplicationSettings or contentDetailViewController_2 ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[JCNavigator sharedNavigator] openURLString:UIApplicationOpenSettingsURLString];
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Detail" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [JCTestModuleMap openContentDetailVCWithCurrentIndex:@"2" testId:nil testArray:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [[JCNavigator sharedNavigator] presentViewController:alertController animated:YES completion:nil];
//    [self.parentViewController presentViewController:alertController animated:YES completion:nil];
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1.f, 1.f);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
