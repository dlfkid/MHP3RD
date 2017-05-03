//
//  AppDelegate.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "AppDelegate.h"

#import "AboutViewController.h"
#import "QuestViewController.h"
#import "MonsterViewController.h"
#import "ArmouryViewController.h"
#import "MapScrollerViewController.h"

@interface AppDelegate ()

{
    UITabBarController *mainTabBar;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor clearColor];
    
    mainTabBar = [self setTabBar];
    [self.window setRootViewController:mainTabBar];
    
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


- (UITabBarController *)setTabBar{
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    
    NSMutableArray *views = [NSMutableArray array];
    
    MapScrollerViewController *map = [[MapScrollerViewController alloc]init];
    QuestViewController *quest = [[QuestViewController alloc]init];
    MonsterViewController *monster = [[MonsterViewController alloc]init];
    ArmouryViewController *armoury = [[ArmouryViewController alloc]init];
    AboutViewController *about = [[AboutViewController alloc]init];
    
    
    [views setArray:@[map,quest,monster,armoury,about]];
    
    NSArray *names = @[@"图",@"任",@"兽",@"兵",@"我"];
    
    NSArray *imageNames = @[@"map",@"quest",@"monster",@"armoury",@"about"];
    
    NSMutableArray *navs = [NSMutableArray array];
    NSMutableArray *images = [NSMutableArray array];
    
    for(int i = 0; i < views.count; i++){
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:views[i]];
        [navs addObject:nav];
        UIImage *image = [UIImage imageNamed:imageNames[i]];
        [images addObject:image];
    }
    
    tabBar.viewControllers = navs;
    
    for(int i = 0; i < views.count; i++ ){
        tabBar.viewControllers[i].tabBarItem.title = names[i];
        tabBar.viewControllers[i].tabBarItem.image = images[i];
    }
    
    UIApplicationShortcutIcon *mapIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation];
    UIApplicationShortcutIcon *questIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeTaskCompleted];
    UIApplicationShortcutIcon *monsterIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    UIApplicationShortcutIcon *armouryIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeContact];
    
    NSDictionary *mapDic = [NSDictionary dictionaryWithObject:@"map" forKey:@"type"];
    NSDictionary *questDic = [NSDictionary dictionaryWithObject:@"quest" forKey:@"type"];
    NSDictionary *monsterDic = [NSDictionary dictionaryWithObject:@"monster" forKey:@"type"];
    NSDictionary *armouryDic = [NSDictionary dictionaryWithObject:@"armoury" forKey:@"type"];
    
    UIApplicationShortcutItem *mapItem = [[UIApplicationShortcutItem alloc]initWithType:@"map" localizedTitle:@"地图" localizedSubtitle:@"查看地图" icon:mapIcon userInfo:mapDic];
    UIApplicationShortcutItem *questItem = [[UIApplicationShortcutItem alloc]initWithType:@"quest" localizedTitle:@"任务" localizedSubtitle:@"查看任务列表" icon:questIcon userInfo:questDic];
    UIApplicationShortcutItem *monsterItem = [[UIApplicationShortcutItem alloc]initWithType:@"monster" localizedTitle:@"怪物" localizedSubtitle:@"怪物信息" icon:monsterIcon userInfo:monsterDic];
    UIApplicationShortcutItem *armouryItem = [[UIApplicationShortcutItem alloc]initWithType:@"armoury" localizedTitle:@"装备" localizedSubtitle:@"装备信息" icon:armouryIcon userInfo:armouryDic];
    
    NSArray *shortCuts = @[mapItem,questItem,monsterItem,armouryItem];
    
    [UIApplication sharedApplication].shortcutItems = shortCuts;
    
    
    return tabBar;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    NSString *type = (NSString *)[shortcutItem.userInfo objectForKey:@"type"];
    if([type isEqualToString:@"map"]) {
        NSLog(@"开启地图");
        [mainTabBar setSelectedIndex:0];
    }
    if([type isEqualToString:@"quest"]){
        NSLog(@"开启任务");
        [mainTabBar setSelectedIndex:1];
    }
    if([type isEqualToString:@"monster"]){
        NSLog(@"开启怪物");
        [mainTabBar setSelectedIndex:2];
    }
    if([type isEqualToString:@"armoury"]){
        NSLog(@"开启装备");
        [mainTabBar setSelectedIndex:3];
    }
}


@end
