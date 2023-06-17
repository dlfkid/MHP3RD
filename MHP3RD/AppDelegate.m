//
//  AppDelegate.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "AppDelegate.h"

#import <MHP3RD-Swift.h>
#import "AboutViewController.h"
#import "MapScrollerViewController.h"
#import "MHPLogger.h"

@interface AppDelegate ()

{
    UITabBarController *mainTabBar;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    mainTabBar = [[MHPTabBarController alloc] init];
    [self.window setRootViewController:mainTabBar];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as
    // an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state. Use this
    // method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later. If your application supports background execution, this method is called
    // instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the
    // background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the
    // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
    performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
               completionHandler:(void (^)(BOOL))completionHandler {
    NSString *type = (NSString *)[shortcutItem.userInfo objectForKey:@"type"];
    if ([type isEqualToString:@"map"]) {
        MHPLog(@"开启地图");
        [mainTabBar setSelectedIndex:0];
    }
    if ([type isEqualToString:@"quest"]) {
        MHPLog(@"开启任务");
        [mainTabBar setSelectedIndex:1];
    }
    if ([type isEqualToString:@"monster"]) {
        MHPLog(@"开启怪物");
        [mainTabBar setSelectedIndex:2];
    }
    if ([type isEqualToString:@"armoury"]) {
        MHPLog(@"开启装备");
        [mainTabBar setSelectedIndex:3];
    }
}

@end
