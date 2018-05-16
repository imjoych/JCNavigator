# JCNavigator
A useful navigator framework of page jumps between modules for iOS development.

## Features
This framework supports the development of iOS 8.0+ in ARC.

* JCNavigator configs.
* Implement module maps.
* Page jumps with method openURL: or openProtocol:.

### JCNavigator configs

Set URL jump rules with hostList for scheme
```objective-c
[[JCNavigator sharedNavigator] addURLScheme:@"joych" hostList:@[@"com.joych.JCNavigatorDemo"]];
```

Module maps configs
```objective-c
[[JCNavigator sharedNavigator] addModuleMap:[JCRootModuleMap new]];
[[JCNavigator sharedNavigator] addModuleMap:[JCTestModuleMap new]];
[JCModuleMap setProtocolPrefix:@"JC"];
```

Navigation configs
```objective-c
[[JCNavigator sharedNavigator] setNavigationControllerClass:[JCNavigationController class]];
```

Set rootViewController
```objective-c
ViewController *vc = [[ViewController alloc] init];
[[JCNavigator sharedNavigator] setRootViewController:vc];
```

### Implement module maps

JCRootModuleMap class
```objective-c
@implementation JCRootModuleMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{@"JC_root": NSClassFromString(@"ViewController")};
}

@end
```

JCTestModuleMap class
```objective-c
@implementation JCTestModuleMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{@"JC_firstLevel": NSClassFromString(@"JCFirstLevelViewController"),
            @"JC_secondLevel": NSClassFromString(@"JCSecondLevelViewController"),
            @"JC_thirdLevel": NSClassFromString(@"JCThirdLevelViewController"),
            @"JC_contentDetail": NSClassFromString(@"JCContentDetailViewController"),
            };
}

- (BOOL)presentedForClass:(Class)viewControllerClass
{
    if ([viewControllerClass isEqual:NSClassFromString(@"JCContentDetailViewController")]) {
        return YES;
    }
    return NO;
}

- (NSArray *)reuseViewControllerClasses
{
    return @[NSClassFromString(@"JCFirstLevelViewController")];
}

- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses
{
    return @{@"JCContentDetailViewController": @{@"pageindex": @"currentIndex"}};
}

@end
```

JC_contentDetail protocol
```objective-c
@protocol JC_contentDetail <NSObject>

@property (nonatomic, strong) NSString *currentIndex;

@end
```

### Page jumps with method open scheme or open URL.

Open scheme
```objective-c
[[JCNavigator sharedNavigator] openScheme:@protocol(JC_firstLevel)];

[[JCNavigator sharedNavigator] openProtocol:@protocol(JC_contentDetail) propertiesBlock:^NSDictionary *{
    return @{@"currentIndex": @"3"};
} presented:YES];
```

Open URL
```objective-c
[[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/secondlevel"]];

[[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.jcnavigatordemo/contentdetail?pageindex=1"];
```
```objective-c
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    return [[JCNavigator sharedNavigator] openURL:url options:options];
}
```

## CocoaPods
To integrate JCNavigator into your iOS project, specify it in your Podfile:

    pod 'JCNavigator'

## Contacts
If you have any questions or suggestions about the framework, please E-mail to contact me.

Author: [Joych](https://github.com/imjoych)    
E-mail: imjoych@gmail.com

## License
JCNavigator is released under the [MIT License](https://github.com/imjoych/JCNavigator/blob/master/LICENSE).

