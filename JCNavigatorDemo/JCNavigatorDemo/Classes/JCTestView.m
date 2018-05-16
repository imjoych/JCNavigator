//
//  JCTestView.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCTestView.h"

@interface JCTestView ()

@property (nonatomic, strong) UIButton *pushButton;
@property (nonatomic, strong) UIButton *presentButton;
@property (nonatomic, copy) void (^pushBlock)(void);
@property (nonatomic, copy) void (^presentBlock)(void);

@end

@implementation JCTestView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pushButton addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pushButton setTitle:@"PushViewController" forState:UIControlStateNormal];
        [_pushButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _pushButton.layer.borderWidth = 1;
        _pushButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _pushButton.layer.masksToBounds = YES;
        [self addSubview:_pushButton];
        
        _presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_presentButton addTarget:self action:@selector(presentAction:) forControlEvents:UIControlEventTouchUpInside];
        [_presentButton setTitle:@"PresentViewController" forState:UIControlStateNormal];
        [_presentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _presentButton.layer.borderWidth = 1;
        _presentButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _presentButton.layer.masksToBounds = YES;
        [self addSubview:_presentButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    _pushButton.bounds = CGRectMake(0, 0, width - 32, 64);
    _pushButton.center = CGPointMake(width / 2, height / 2 - 64);
    _presentButton.bounds = _pushButton.bounds;
    _presentButton.center = CGPointMake(width / 2, height / 2 + 64);
}

- (void)pushAction:(id)sender
{
    if (self.pushBlock) {
        self.pushBlock();
    }
}

- (void)presentAction:(id)sender
{
    if (self.presentBlock) {
        self.presentBlock();
    }
}

+ (instancetype)viewWithPushBlock:(void (^)(void))pushBlock presentBlock:(void (^)(void))presentBlock
{
    JCTestView *view = [JCTestView new];
    view.pushBlock = ^{
        if (pushBlock) {
            pushBlock();
        }
    };
    view.presentBlock = ^{
        if (presentBlock) {
            presentBlock();
        }
    };
    return view;
}

- (void)resetPresentTitle:(NSString *)title
{
    [self.presentButton setTitle:title forState:UIControlStateNormal];
}

@end
