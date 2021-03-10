//
//  AppDelegate.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "JCNavigator.h"
#import "JCNavigationController.h"
#import "JCTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark -

- (void)navigatorConfigs
{
    [[JCNavigator sharedNavigator] addURLScheme:@"joych" hostList:@[@"com.joych.JCNavigatorDemo"]];
    [[JCNavigator sharedNavigator] setNavigationControllerClass:[JCNavigationController class]];
}

- (void)setNavigationBarAppearance
{
    UIColor *tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor, NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [[UINavigationBar appearance] setBarTintColor:tintColor];
    [[UINavigationBar appearance] setTintColor:tintColor];
    UIImage *image = [self createImageWithColor:[UIColor darkGrayColor]];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
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

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self navigatorConfigs];
    [self setNavigationBarAppearance];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    [[JCNavigator sharedNavigator] setRootViewController:[ViewController new]];
//    [[JCNavigator sharedNavigator] setRootViewController:[[JCNavigationController alloc] initWithRootViewController:[ViewController new]]];
    [[JCNavigator sharedNavigator] setRootViewController:[JCTabBarController new]];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    __block BOOL opened = NO;
    [[JCNavigator sharedNavigator] openURL:url options:options completionHandler:^(BOOL success) {
        opened = success;
    }];
    return opened;
}

@end
