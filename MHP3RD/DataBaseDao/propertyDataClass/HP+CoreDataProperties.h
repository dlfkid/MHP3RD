//
//  HP+CoreDataProperties.h
//  
//
//  Created by Ivan_deng on 2017/3/27.
//
//

#import "HP+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HP (CoreDataProperties)

+ (NSFetchRequest<HP *> *)fetchRequest;

@property (nonatomic) float hunterRank;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *selfIntroduce;
@property (nonatomic) float questVillage;
@property (nonatomic) float questGuildLow;
@property (nonatomic) float questGuildHigh;
@property (nonatomic) int16_t id;
@property (nullable, nonatomic, retain) NSData *pic;

@end

NS_ASSUME_NONNULL_END
