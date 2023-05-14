//
//  ProfileDataAssistObject.m
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "ProfileDataAssistObject.h"
#import "HunterProfile.h"
#import "HP+CoreDataClass.h"

@implementation ProfileDataAssistObject

static ProfileDataAssistObject *instance = nil;

+ (ProfileDataAssistObject *)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (NSMutableArray *)searchAllProfile {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HP" inManagedObjectContext:context];
    NSFetchRequest *fetchRequset = [[NSFetchRequest alloc]init];
    fetchRequset.entity = entity;
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"id" ascending:true selector:nil];
    NSArray *sortDescriptors = @[sort];
    fetchRequset.sortDescriptors = sortDescriptors;
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequset error:&error];
    if(error != nil) {
        return nil;
    }else {
        NSMutableArray *result = [[NSMutableArray alloc]init];
        for(HP *sample in listData) {
            HunterProfile *Profile = [[HunterProfile alloc]initWithName:sample.name andID:sample.id andTitile:sample.title andSelfy:sample.selfIntroduce andQV:sample.questVillage andQGL:sample.questGuildLow andQGH:sample.questGuildHigh andHR:sample.hunterRank andPic:sample.pic];
            [result addObject:Profile];
        }
        return result;
    }
}

- (HunterProfile *)searchProfileByID:(int16_t)ID {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HP" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@",ID];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if(error != nil) {
        return nil;
    }else {
        HP *sample = [listData lastObject];
        HunterProfile *profile = [[HunterProfile alloc]initWithName:sample.name andID:sample.id andTitile:sample.title andSelfy:sample.selfIntroduce andQV:sample.questVillage andQGL:sample.questGuildLow andQGH:sample.questGuildHigh andHR:sample.hunterRank andPic:sample.pic];
        return profile;
    }
}

- (HunterProfile *)searchProfileByName:(NSString *)name {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HP" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if(error != nil) {
        return nil;
    }else {
        HP *sample = [listData lastObject];
        HunterProfile *profile = [[HunterProfile alloc]initWithName:sample.name andID:sample.id andTitile:sample.title andSelfy:sample.selfIntroduce andQV:sample.questVillage andQGL:sample.questGuildLow andQGH:sample.questGuildHigh andHR:sample.hunterRank andPic:sample.pic];
        return profile;
    }
}

- (void)removeProfileByID:(int16_t)ID {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HP" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@",ID];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if(error != nil) {
        MHPLog(@"error: %@", error.localizedDescription);
    }else {
        HP *sample = [listData lastObject];
        [context deleteObject:sample];
        [self saveContext];
    }
}

- (void)removeAllProfiles {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HP" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"id = %@" ascending:true selector:nil];
    NSArray *sortDescriptors = @[sort];
    fetchRequest.sortDescriptors = sortDescriptors;
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if(error != nil) {
    }else {
        for (HP *sample in listData) {
            [context deleteObject:sample];
            [self saveContext];
        }
    }
}

- (void)removeProfileByName:(NSString *)name {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HP" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if(error != nil) {
        MHPLog(@"error: %@", error.localizedDescription);
    }else {
        HP *sample = [listData lastObject];
        [context deleteObject:sample];
        [self saveContext];
    }
}

- (void)createProfile:(HunterProfile *)profile {
    NSManagedObjectContext *context = [self managedObjectContext];
    HP *newEntity = [NSEntityDescription insertNewObjectForEntityForName:@"HP" inManagedObjectContext:context];
    newEntity.name = profile.name;
    newEntity.title = profile.title;
    newEntity.id = profile.ID;
    newEntity.selfIntroduce = profile.selfIntroduce;
    newEntity.questGuildHigh = profile.questGuildHigh;
    newEntity.questGuildLow = profile.questGuildLow;
    newEntity.questVillage = profile.questVillage;
    newEntity.pic = profile.pic;
    [self saveContext];
}

- (void)modifyProfile:(HunterProfile *)profile {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HP" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    MHPLog(@"%d", profile.ID);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %d",profile.ID];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if(error != nil) {
        MHPLog(@"error: %@", error.localizedDescription);
    }else {
        HP *sample = [listData lastObject];
        sample.name = profile.name;
        sample.title = profile.title;
        sample.selfIntroduce = profile.selfIntroduce;
        sample.questGuildHigh = profile.questGuildHigh;
        sample.questGuildLow = profile.questGuildLow;
        sample.questVillage = profile.questVillage;
        sample.pic = profile.pic;
        [self saveContext];
    }
}

@end
