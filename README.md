# JCNavigator
A useful navigator framework of page jumps between modules for iOS development.

## Features
This framework supports the development of iOS 8.0+ in ARC.

* JCNavigator configs.
* Implement URL maps for modules.
* Page jumps with method openURL: or openScheme.

### JCNavigator configs

Set URL jump rules with hostList for scheme
```objective-c
[[JCNavigator sharedNavigator] addURLScheme:@"joych" hostList:@[@"com.joych.JCNavigatorDemo"]];
```

URL maps configs
```objective-c
[[JCNavigator sharedNavigator] addURLMap:[JCRootURLMap new]];
[[JCNavigator sharedNavigator] addURLMap:[JCTestURLMap new]];
[JCURLMap setProtocolPrefix:@"JC"];
```

Navigation configs
```objective-c
[[JCNavigator sharedNavigator] popButtonSettingBlock:^(UIViewController *willOpenedViewController) {
    [willOpenedViewController jc_setupLeftBackBarButtonItem];
}];
[[JCNavigator sharedNavigator] dismissButtonSettingBlock:^(UIViewController *willOpenedViewController) {
    [willOpenedViewController jc_setupLeftCloseBarButtonItem];
}];
[[JCNavigator sharedNavigator] setNavigationControllerClass:[JCNavigationController class]];
```

Set rootViewController
```objective-c
ViewController *vc = [[ViewController alloc] init];
[[JCNavigator sharedNavigator] setRootViewController:vc];
```

### Implement URL maps for modules

JCRootURLMap class
```objective-c
@implementation JCRootURLMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{NSStringFromProtocol(@protocol(JC_root)): [ViewController class]};
}

@end
```

JCTestURLMap class
```objective-c
@implementation JCTestURLMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{NSStringFromProtocol(@protocol(JC_firstLevel)): [JCFirstLevelViewController class],
            NSStringFromProtocol(@protocol(JC_secondLevel)): [JCSecondLevelViewController class],
            NSStringFromProtocol(@protocol(JC_thirdLevel)): [JCThirdLevelViewController class],
            NSStringFromProtocol(@protocol(JC_contentDetail)): [JCContentDetailViewController class],
            };
}

- (NSArray *)reuseViewControllerClasses
{
    return @[[JCFirstLevelViewController class]];
}

- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses
{
    return @{NSStringFromClass([JCContentDetailViewController class]): @{@"pageindex": @"currentIndex"}};
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

[[JCNavigator sharedNavigator] openScheme:@protocol(JC_contentDetail) settingBlock:^(UIViewController<JC_contentDetail> *willOpenedViewController) {
    willOpenedViewController.currentIndex = @"2";
} presented:YES];
```

Open URL
```objective-c
[[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.JCNavigatorDemo/secondlevel"];

[[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.jcnavigatordemo/contentdetail?pageindex=1"];
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

