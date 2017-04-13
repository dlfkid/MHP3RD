//
//  PlistManager.h
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/14.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistManager : NSObject

@property(nonatomic,strong) NSString *plistPath;

+ (PlistManager *)getInstanceWithPlist:(NSString *)plist;

- (NSMutableArray *)findAllMonsterInfoForType:(int)monsterType;

- (NSMutableArray *)findAllQuestInfoForStar:(int)stars;

- (NSMutableArray *)findAllWeaponInfo;

- (void)reloadPlistFile;

- (void)reloadPlistFileAgain;

@end
