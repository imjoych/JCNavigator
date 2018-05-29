//
//  JCContentDetailViewController.h
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JC_contentDetail <NSObject>

@property (nonatomic, strong) NSString *currentIndex;
@property (nonatomic, strong) NSString *testId;
@property (nonatomic, strong) NSArray *testArray;

@end

@interface JCContentDetailViewController : UIViewController<JC_contentDetail>

@end
