# JCNavigator
A decoupled navigator framework of jumping between modules or apps for iOS development. 

## Features
This framework supports the development of iOS 8.0+ in ARC.

* JCNavigator configs.
* Implement module maps.
* Jump operations with method openURL: or openWithMapKey:.
* Parameters passing between modules.

### JCNavigator configs

Set URL jump rules with hostList for scheme
```objective-c
[[JCNavigator sharedNavigator] addURLScheme:@"joych" hostList:@[@"com.joych.JCNavigatorDemo"]];
```

Module maps configs
```objective-c
[[JCNavigator sharedNavigator] addModuleMap:[JCRootModuleMap new]];
[[JCNavigator sharedNavigator] addModuleMap:[JCTestModuleMap new]];
```

Set rootViewController
```objective-c
ViewController *vc = [[ViewController alloc] init];
[[JCNavigator sharedNavigator] setRootViewController:vc];
```

### Implement module maps

JCTestModuleMap class is declared as the subclass of JCModuleMap.
* Map key should be defined with the same prefix and appended with "_".
* Map key will be used in the category of JCNavigator which associated with this module.
```objective-c
//  JCTestModuleMap.h

FOUNDATION_EXPORT NSString *const JCFirstLevelMapKey;
FOUNDATION_EXPORT NSString *const JCSecondLevelMapKey;
FOUNDATION_EXPORT NSString *const JCThirdLevelMapKey;
FOUNDATION_EXPORT NSString *const JCContentDetailMapKey;

@interface JCTestModuleMap : JCModuleMap

@end
```
```objective-c
//  JCTestModuleMap.m

NSString *const JCFirstLevelMapKey = @"JC_firstLevel";
NSString *const JCSecondLevelMapKey = @"JC_secondLevel";
NSString *const JCThirdLevelMapKey = @"JC_thirdLevel";
NSString *const JCContentDetailMapKey = @"JC_contentDetail";

@implementation JCTestModuleMap

- (NSDictionary<NSString *,Class> *)classesForMapKeys
{
    return @{JCFirstLevelMapKey: NSClassFromString(@"JCFirstLevelViewController"),
             JCSecondLevelMapKey: NSClassFromString(@"JCSecondLevelViewController"),
             JCThirdLevelMapKey: NSClassFromString(@"JCThirdLevelViewController"),
             JCContentDetailMapKey: NSClassFromString(@"JCContentDetailViewController"),
             };
}

- (BOOL)presentedForClass:(Class)viewControllerClass
{
    if ([viewControllerClass isEqual:NSClassFromString(@"JCContentDetailViewController")]) {
        return YES;
    }
    return NO;
}

- (NSArray<Class> *)reuseViewControllerClasses
{
    return @[NSClassFromString(@"JCFirstLevelViewController")];
}

- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses
{
    return @{@"JCContentDetailViewController": @{@"pageindex": @"currentIndex"}};
}

@end
```

### Jump operations with method openURL: or openWithMapKey:

Open URL between apps or modules.
```objective-c
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    return [[JCNavigator sharedNavigator] openURL:url options:options];
}
```
```objective-c
[[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/firstlevel"]];
[[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.jcnavigatordemo/contentdetail?pageindex=1"];
```

Category of  JCNavigator implemented interfaces which are used for jumps between modules.
```objective-c
//  JCNavigator+JCTestModuleInterface.h

@interface JCNavigator (JCTestModuleInterface)

+ (void)openFirstLevelViewController;

+ (void)openSecondLevelViewController;

+ (void)openThirdLevelViewController;

+ (void)openContentDetailViewControllerWithCurrentIndex:(NSString *)currentIndex
                                                 testId:(NSString *)testId
                                              testArray:(NSArray *)testArray;

@end
```
```objective-c
//  JCNavigator+JCTestModuleInterface.m

@implementation JCNavigator (JCTestModuleInterface)

+ (void)openFirstLevelViewController
{
    [[JCNavigator sharedNavigator] openWithMapKey:JCFirstLevelMapKey];
}

+ (void)openSecondLevelViewController
{
    [[JCNavigator sharedNavigator] openWithMapKey:JCSecondLevelMapKey];
}

+ (void)openThirdLevelViewController
{
    [[JCNavigator sharedNavigator] openWithMapKey:JCThirdLevelMapKey];
}

+ (void)openContentDetailViewControllerWithCurrentIndex:(NSString *)currentIndex testId:(NSString *)testId testArray:(NSArray           *)testArray
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    if ([currentIndex isKindOfClass:[NSString class]]) {
        params[@"currentIndex"] = currentIndex;
    }
    if ([testId isKindOfClass:[NSString class]]) {
        params[@"testId"] = testId;
    }
    if ([testArray isKindOfClass:[NSArray class]]) {
        params[@"testArray"] = testArray;
    }
    [[JCNavigator sharedNavigator] openWithMapKey:JCContentDetailMapKey propertiesBlock:^NSDictionary *{
        return params;
    } presented:YES];
}

@end
```

### Parameters passing between modules

Parameters passing between modules is realized by properties assignment.
* Properties are suggested to be declared as NSString class because openURL: method only supports this data type.
* Properties also can be declared as NSArray / NSDictionary / NSSet / UIImage and so on data types, which can be used with openWithMapKey:propertiesBlock: method. For decoupling between modules, although you can use a custom object, it is not recommended.
```objective-c
//  JCContentDetailViewController.h

@protocol JC_contentDetail <NSObject>

@property (nonatomic, strong) NSString *currentIndex;
@property (nonatomic, strong) NSString *testId;
@property (nonatomic, strong) NSArray *testArray;

@end

@interface JCContentDetailViewController : UIViewController<JC_contentDetail>

@end
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

