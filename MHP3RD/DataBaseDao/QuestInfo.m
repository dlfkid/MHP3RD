//
//  QuestInfo.m
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/14.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "QuestInfo.h"

@implementation QuestInfo

- (instancetype)initWithName:(NSString *)name
                    andBrief:(NSString *)brief
                      andPic:(NSString *)pic
                      andKey:(BOOL)key{
    self = [super init];
    self.questName = name;
    self.questBrief = brief;
    self.questPic = pic;
    self.key = key;
    return self;
}

@end
