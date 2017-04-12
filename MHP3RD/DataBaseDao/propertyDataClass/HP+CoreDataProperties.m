//
//  HP+CoreDataProperties.m
//  
//
//  Created by Ivan_deng on 2017/3/27.
//
//

#import "HP+CoreDataProperties.h"

@implementation HP (CoreDataProperties)

+ (NSFetchRequest<HP *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HP"];
}

@dynamic hunterRank;
@dynamic name;
@dynamic title;
@dynamic selfIntroduce;
@dynamic questVillage;
@dynamic questGuildLow;
@dynamic questGuildHigh;
@dynamic id;
@dynamic pic;

@end
