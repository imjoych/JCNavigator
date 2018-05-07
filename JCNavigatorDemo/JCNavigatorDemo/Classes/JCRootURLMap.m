//
//  JCRootURLMap.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCRootURLMap.h"
#import "JC_root.h"
#import "ViewController.h"

@implementation JCRootURLMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{NSStringFromProtocol(@protocol(JC_root)): [ViewController class]};
}

@end
