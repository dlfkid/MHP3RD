//
//  HunterProfile.m
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "HunterProfile.h"

@implementation HunterProfile

- (instancetype)initWithName:(NSString *)name andID:(int16_t)ID andTitile:(NSString *)title andSelfy:(NSString *)selfInfroduce andQV:(float)questvillage andQGL:(float)questGuildLow andQGH:(float)questGuildHigh andHR:(float)HunterRank andPic:(NSData *)pic {
    self = [super init];
    self.name = name;
    self.ID = ID;
    self.pic = pic;
    self.title = title;
    self.selfIntroduce = selfInfroduce;
    self.questVillage = questvillage;
    self.questGuildLow = questGuildLow;
    self.questGuildHigh = questGuildHigh;
    self.HunterRank = HunterRank;
    return self;
}

@end
