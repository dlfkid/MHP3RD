//
//  HunterProfile.h
//  DataBaseDao
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HunterProfile : NSObject

@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) NSString * selfIntroduce;
@property(nonatomic,assign) float questVillage;
@property(nonatomic,assign) float questGuildLow;
@property(nonatomic,assign) float questGuildHigh;
@property(nonatomic,assign) float HunterRank;
@property(nonatomic,assign) int16_t ID;
@property(nonatomic,strong) NSData * pic;

- (instancetype)initWithName:(NSString *)name
                       andID:(int16_t)ID
                   andTitile:(NSString *)title
                    andSelfy:(NSString *)selfInfroduce
                       andQV:(float)questvillage
                      andQGL:(float)questGuildLow
                      andQGH:(float)questGuildHigh
                       andHR:(float)HunterRank
                      andPic:(NSData *)pic;

@end
