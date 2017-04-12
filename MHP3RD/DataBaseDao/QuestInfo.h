//
//  QuestInfo.h
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/14.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestInfo : NSObject

@property(nonatomic,strong) NSString *questName;

@property(nonatomic,strong) NSString *questBrief;

@property(nonatomic,strong) NSString *questPic;

@property(nonatomic,assign) BOOL key;

- (instancetype)initWithName:(NSString *)name
                    andBrief:(NSString *)brief
                      andPic:(NSString *)pic
                      andKey:(BOOL)key;

@end
