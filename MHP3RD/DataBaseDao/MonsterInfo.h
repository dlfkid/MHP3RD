//
//  MonsterInfo.h
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/20.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonsterInfo : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *pic;
@property(nonatomic,strong) NSString *weak;
@property(nonatomic,strong) NSString *atk;

- (instancetype)initWithName:(NSString *)name
                      andPic:(NSString *)pic
                     andWeak:(NSString *)weak
                      andAtk:(NSString *)atk;

@end
