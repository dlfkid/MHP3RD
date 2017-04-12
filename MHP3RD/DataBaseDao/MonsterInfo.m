//
//  MonsterInfo.m
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/20.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "MonsterInfo.h"

@implementation MonsterInfo

- (instancetype)initWithName:(NSString *)name andPic:(NSString *)pic andWeak:(NSString *)weak andAtk:(NSString *)atk{
    self = [super init];
    self.name = name;
    self.pic = pic;
    self.weak = weak;
    self.atk = atk;
    return self;
}

@end
