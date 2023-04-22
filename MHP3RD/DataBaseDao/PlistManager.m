    //
    //  PlistManager.m
    //  DataBaseDao
    //
    //  Created by Ivan_deng on 2017/3/14.
    //  Copyright © 2017年 Ivan_deng. All rights reserved.
    //

    #import "PlistManager.h"
    #import "QuestInfo.h"
    #import "MonsterInfo.h"
    #import "WeaponInfo.h"

    @implementation PlistManager

    static PlistManager *sharedSingleton = nil;

    - (NSString *)applicationDocumentDirectoryFileForPlist:(NSString *)plist {
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
        NSString *path = [documentDirectory stringByAppendingPathComponent:plist];
        return path;
    }

    - (void)configurePlistPath:(NSString *)plist {
        NSString *plistPath = [self applicationDocumentDirectoryFileForPlist:plist];
        self.plistPath = plistPath;
    }

    - (void)createEditableCopyOfDataBaseIfNeeded:(NSString *)plist {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL dbexits = [fileManager fileExistsAtPath:self.plistPath];
        NSBundle *framewokBundle = [NSBundle bundleForClass:[self class]];
        NSString *frameworkBundlePath = [framewokBundle resourcePath];
        NSString *defaultDBPath = [frameworkBundlePath stringByAppendingPathComponent:plist];
        NSError *error = nil;
        //[fileManager removeItemAtPath:self.plistPath error:&error];
        if(!dbexits){
            BOOL SUCCESS = [fileManager copyItemAtPath:defaultDBPath toPath:self.plistPath error:&error];
            NSAssert(SUCCESS,@"错误写入文件");
        }
    }

    - (void)reloadPlistFileAgain{
        NSArray *nameArr = @[@"quest.plist",@"low.plist",@"high.plist"];
        for(int i = 0; i < 3; i++){
            [self configurePlistPath:nameArr[i]];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSBundle *framewokBundle = [NSBundle bundleForClass:[self class]];
            NSString *frameworkBundlePath = [framewokBundle resourcePath];
            NSString *defaultDBPath = [frameworkBundlePath stringByAppendingPathComponent:nameArr[i]];
            NSError *error = nil;
            [fileManager removeItemAtPath:self.plistPath error:&error];
            [fileManager copyItemAtPath:defaultDBPath toPath:self.plistPath error:&error];
        }
    }

    - (void)reloadPlistFile{
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSBundle *framewokBundle = [NSBundle bundleForClass:[self class]];
            NSString *frameworkBundlePath = [framewokBundle resourcePath];
            NSString *defaultDBPath = [frameworkBundlePath stringByAppendingPathComponent:@"Monster.plist"];
            NSError *error = nil;
            [fileManager removeItemAtPath:self.plistPath error:&error];
            [fileManager copyItemAtPath:defaultDBPath toPath:self.plistPath error:&error];
    }

    + (PlistManager *)getInstanceWithPlist:(NSString *)plist {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            sharedSingleton = [[self alloc]init];
        });
        [sharedSingleton configurePlistPath:plist];
        [sharedSingleton createEditableCopyOfDataBaseIfNeeded:plist];
        return sharedSingleton;
    }

    - (NSMutableArray *)findAllQuestInfoForStar:(int)stars {
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:self.plistPath];
        NSArray *questArr = array[stars];
        NSMutableArray *result = [NSMutableArray array];
        for(NSDictionary *info in questArr){
            NSString *name = [info objectForKey:@"name"];
            NSString *pic = [info objectForKey:@"pic"];
            NSString *brief = [info objectForKey:@"brief"];
            BOOL key = [(NSNumber *)[info objectForKey:@"key"] boolValue];
            QuestInfo *newQuestInfo = [[QuestInfo alloc]initWithName:name andBrief:brief andPic:pic andKey:key];
            [result addObject:newQuestInfo];
        }
        return result;
    }

    - (NSMutableArray *)findAllMonsterInfoForType:(int)monsterType {
        NSArray *Arr = [[NSMutableArray alloc]initWithContentsOfFile:self.plistPath];
        NSArray *monsterArr = Arr[monsterType];
        NSMutableArray *result = [NSMutableArray array];
        for(NSDictionary *monster in monsterArr){
            NSString *name = [monster objectForKey:@"name"];
            NSString *pic = [monster objectForKey:@"pic"];
            NSString *weak = [monster objectForKey:@"weak"];
            NSString *atk = [monster objectForKey:@"atk"];
            MonsterInfo *newMonster = [[MonsterInfo alloc]initWithName:name andPic:pic andWeak:weak andAtk:atk];
            [result addObject:newMonster];
        }
        return result;
    }

    - (NSMutableArray *)findAllWeaponInfo{
        NSArray *weaponArr = [[NSMutableArray alloc]initWithContentsOfFile:self.plistPath];
        NSMutableArray *resultArr = [[NSMutableArray alloc]init];
        for(NSDictionary *weapon in weaponArr){
            NSString *name = [weapon objectForKey:@"name"];
            NSString *pic = [weapon objectForKey:@"pic"];
            NSString *brief = [weapon objectForKey:@"brief"];
            WeaponInfo *newWeapon = [[WeaponInfo alloc]initWithName:name andPic:pic andBrief:brief];
            [resultArr addObject:newWeapon];
        }
        return resultArr;
    }

    @end
