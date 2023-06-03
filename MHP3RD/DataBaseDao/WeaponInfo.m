//
//  WeaponInfo.m
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/23.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "WeaponInfo.h"
#import "MHPLogger.h"

@implementation WeaponInfo

- (instancetype)initWithName:(NSString *)name
                      andPic:(NSString *)pic
                    andBrief:(NSString *)brief{
    self = [super init];
    self.name = name;
    self.pic = pic;
    self.brief = brief;
    return self;
}

@end
