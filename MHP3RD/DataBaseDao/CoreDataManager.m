//
//  CoreDataManager.m
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "CoreDataManager.h"
#import "MHPLogger.h"

#define MODELNAME @"HunterProfile"
#define ENEITYNAME @"HP"

@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistenceStoreCoordinator = _persistenceStoreCoordinator;

#pragma mark - Core Data栈

//获得应用程序沙箱document目录
- (NSURL *)applicaitonDocumentDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//返回被管理对象模型

- (NSManagedObjectModel *)managedObjectModel{
    if(_managedObjectModel != nil){
        return _managedObjectModel;
    }
    NSBundle *frameworkBundle = [NSBundle bundleForClass:self.class];
    NSURL *modelURL = [frameworkBundle URLForResource:MODELNAME withExtension:@"momd"];
    if(modelURL != nil){
        _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
        return _managedObjectModel;
    }else{
        MHPLog(@"获取modelURL失败！程序崩溃");
        return nil;
    }
}

//返回持久化储存协调器

- (NSPersistentStoreCoordinator *)persistenceStoreCoordinator{
    if(_persistenceStoreCoordinator){
        return _persistenceStoreCoordinator;
    }
    NSURL *storeURL = [[self applicaitonDocumentDirectory]URLByAppendingPathComponent:[ENEITYNAME stringByAppendingString:@".sqlite"]];
    _persistenceStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    NSError *error = nil;
    if(![_persistenceStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        MHPLog(@"数据加载失败！");
        abort();
    }
    return _persistenceStoreCoordinator;
}

//返回被管理对象上下文
- (NSManagedObjectContext *)managedObjectContext{
    if(_managedObjectContext != nil){
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistenceStoreCoordinator];
    if(!coordinator){
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

- (void)saveContext{
    NSManagedObjectContext *context = [self managedObjectContext];
    if(context != nil){
        NSError *error = nil;
        if([context hasChanges] && ![context save:&error]){
            MHPLog(@"数据保存出错！%@", error.localizedDescription);
            abort();
        }
    }
}

@end
