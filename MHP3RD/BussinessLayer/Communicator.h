//
//  Communicator.h
//  BussinessLayer
//
//  Created by Ivan_deng on 2017/3/14.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MISSIONTYPE) {
    VILLAGE,
    GUILD_LOW,
    GUILD_HIGH,
};

typedef NS_ENUM(NSUInteger, MONSTERTYPE) {
    BirdDragon,
    Beast,
    TeethDragon,
    SeaDragon,
    BeastDragon,
    Dragon,
    AcientDragon,
};

@class HunterProfile;
@interface Communicator : NSObject

+ (NSMutableArray *)getAllHunterProfile;

+ (HunterProfile *)getHunterpProfileByName:(NSString *)name;

+ (HunterProfile *)getHunterpProfileByID:(int16_t)ID;

+ (void)AddHunterProfile:(HunterProfile *)profile;

+ (void)clearAllHunterProfile;

+ (void)deleteHunterProfile:(HunterProfile *)profile;

+ (void)changeHunterProfile:(HunterProfile *)profile;

+ (NSData *)postDataTask;

+ (NSURL *)getWebImageURL;

@end
