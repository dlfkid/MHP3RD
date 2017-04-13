//
//  ProfileDataAssistObject.h
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "CoreDataManager.h"


@class HunterProfile;
@interface ProfileDataAssistObject : CoreDataManager

+ (ProfileDataAssistObject *)getInstance;

- (NSMutableArray *)searchAllProfile;

- (HunterProfile *)searchProfileByName:(NSString *)name;

- (HunterProfile *)searchProfileByID:(int16_t)ID;

- (void)removeProfileByName:(NSString *)name;

- (void)removeProfileByID:(int16_t)ID;

- (void)removeAllProfiles;

- (void)createProfile:(HunterProfile *)profile;

- (void)modifyProfile:(HunterProfile *)profile;

@end
