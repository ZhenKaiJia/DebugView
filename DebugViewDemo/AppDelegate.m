//
//  AppDelegate.m
//  DebugViewDemo
//
//  Created by Justin on 16/10/31.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "AppDelegate.h"
#import "VendorMacro.h"
#import "AViewController.h"
#import "BViewController.h"
#import "DebugView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = self.mainTabBarController;
        [self.window makeKeyAndVisible];
    }
    
    {
        /**
         *仅供学习参考。。。。。。。你懂的
         */
        if (DebugToolEnable) {
            if (DebugToolEnable) {//debug放前面要设置网络环境
                DebugView *debugView = [[DebugView alloc] initWithFrame:CGRectZero];
                debugView.rootVC = self.mainTabBarController;
                [debugView showOverWindow];
                [self.window addSubview:debugView];
                // 避免apple的一个bug
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(resetWindow)
                                                             name:UIWindowDidBecomeKeyNotification object:nil];
            }
        }
    }
    return YES;
}

- (void)resetWindow{
    [self.window makeKeyWindow];
}

- (UITabBarController *)mainTabBarController {
    if (!_mainTabBarController) {
        _mainTabBarController = [[UITabBarController alloc] init];
        _mainTabBarController.tabBar.barTintColor = [UIColor whiteColor];
        
        AViewController *mainVC = [[AViewController alloc] init];
        BViewController *exclusiveVC = [[BViewController alloc] init];
        
        UINavigationController *mainNavigation = [[UINavigationController alloc] initWithRootViewController:mainVC];
        UINavigationController *exclusiveNavigation = [[UINavigationController alloc] initWithRootViewController:exclusiveVC];
        
        _mainTabBarController.viewControllers = @[ mainNavigation, exclusiveNavigation ];
        
        NSArray *titles = @[ @"首页", @"分类"];
        
        [_mainTabBarController.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            item.title = titles[idx];
        }];
    }
    return _mainTabBarController;
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


@end
