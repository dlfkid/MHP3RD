//
//  HP+CoreDataProperties.h
//  
//
//  Created by Ivan_deng on 2017/4/12.
//
//

#import "HP+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HP (CoreDataProperties)

+ (NSFetchRequest<HP *> *)fetchRequest;

@property (nonatomic) float hunterRank;
@property (nonatomic) int16_t id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *pic;
@property (nonatomic) float questGuildHigh;
@property (nonatomic) float questGuildLow;
@property (nonatomic) float questVillage;
@property (nullable, nonatomic, copy) NSString *selfIntroduce;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
