//
//  HP+CoreDataProperties.m
//  
//
//  Created by Ivan_deng on 2017/4/12.
//
//

#import "HP+CoreDataProperties.h"
#import "MHPLogger.h"

@implementation HP (CoreDataProperties)

+ (NSFetchRequest<HP *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HP"];
}

@dynamic hunterRank;
@dynamic id;
@dynamic name;
@dynamic pic;
@dynamic questGuildHigh;
@dynamic questGuildLow;
@dynamic questVillage;
@dynamic selfIntroduce;
@dynamic title;

@end
