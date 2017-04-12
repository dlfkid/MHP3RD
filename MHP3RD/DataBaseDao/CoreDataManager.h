//
//  CoreDataManager.h
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataManager : NSObject

@property(readonly,nonatomic,strong) NSManagedObjectModel *managedObjectModel;
@property(readonly,nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property(readonly,nonatomic,strong) NSPersistentStoreCoordinator *persistenceStoreCoordinator;

- (void)saveContext;

- (NSURL *)applicaitonDocumentDirectory;


@end
