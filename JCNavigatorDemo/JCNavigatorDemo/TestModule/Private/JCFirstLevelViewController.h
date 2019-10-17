//
//  JCFirstLevelViewController.h
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCFirstLevelVCDelegate <NSObject>

@property (nonatomic, strong) NSString *comeFrom;

@end

@interface JCFirstLevelViewController : UIViewController<JCFirstLevelVCDelegate>

@end
