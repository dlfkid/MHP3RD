//
//  Communicator.m
//  BussinessLayer
//
//  Created by Ivan_deng on 2017/3/14.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "Communicator.h"
#import "CoreDataManager.h"
#import "WeaponInfo.h"
#import "QuestInfo.h"
#import "MonsterInfo.h"
#import "PlistManager.h"
#import "HunterProfile.h"
#import "ProfileDataAssistObject.h"

@implementation Communicator

+ (NSMutableArray *)getQuestInfoMationForType:(MISSIONTYPE)questType andStars:(int)stars{
    NSString *questFileName;
    switch (questType) {
        case VILLAGE:
            questFileName = @"quest.plist";
            NSLog(@"Plist name is %@",questFileName);
            break;
        case GUILD_LOW:
            questFileName = @"guildlow.plist";
            break;
        default:
            questFileName = @"guildhigh.plist";
            break;
    }
    PlistManager *dataPass = [PlistManager getInstanceWithPlist:questFileName];
    return [dataPass findAllQuestInfoForStar:stars];
}

+ (NSMutableArray *)getMonsterInfomattionForType:(MONSTERTYPE)monsterType {
    PlistManager *dataPass = [PlistManager  getInstanceWithPlist:@"Monster.plist"];
    return [dataPass findAllMonsterInfoForType:monsterType];
}

+ (NSMutableArray *)getWeaponInfomation{
    PlistManager *dataPass = [PlistManager getInstanceWithPlist:@"weapon.plist"];
    return [dataPass findAllWeaponInfo];
}

+ (void)refreshPlistData{
    PlistManager *dataPass = [PlistManager getInstanceWithPlist:@"quest.plist"];
    [dataPass reloadPlistFileAgain];
}

+ (void)refreshMonsterData{
    PlistManager *dataPass = [PlistManager getInstanceWithPlist:@"Monster.plist"];
    [dataPass reloadPlistFile];
}

#pragma mark - HunterProfile

+ (NSMutableArray *)getAllHunterProfile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    return [pdao searchAllProfile];
}

+ (HunterProfile *)getHunterpProfileByName:(NSString *)name {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    return [pdao searchProfileByName:name];
}

+ (HunterProfile *)getHunterpProfileByID:(int16_t)ID {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    return [pdao searchProfileByID:ID];
}

+ (void)AddHunterProfile:(HunterProfile *)profile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    [pdao createProfile:profile];
}

+ (void)deleteHunterProfile:(HunterProfile *)profile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    [pdao removeProfileByName:profile.name];
}

+ (void)changeHunterProfile:(HunterProfile *)profile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    [pdao modifyProfile:profile];
}

+ (void)clearAllHunterProfile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    [pdao removeAllProfiles];
}

@end
