//
//  WeaponInfo.h
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/23.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeaponInfo : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *pic;
@property(nonatomic,strong) NSString *brief;

- (instancetype)initWithName:(NSString *)name
                      andPic:(NSString *)pic
                    andBrief:(NSString *)brief;

@end
