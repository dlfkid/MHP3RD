//
//  Communicator.m
//  BussinessLayer
//
//  Created by Ivan_deng on 2017/3/14.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "Communicator.h"
#import "CoreDataManager.h"
#import "HunterProfile.h"
#import "ProfileDataAssistObject.h"
#import "MHPLogger.h"

@implementation Communicator

#pragma mark - HunterProfile

+ (NSMutableArray *)getAllHunterProfile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    return [pdao searchAllProfile];
}

+ (HunterProfile *)getHunterpProfileByName:(NSString *)name {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    return [pdao searchProfileByName:name];
}

+ (HunterProfile *)getHunterpProfileByID:(int16_t)ID {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    return [pdao searchProfileByID:ID];
}

+ (void)AddHunterProfile:(HunterProfile *)profile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    [pdao createProfile:profile];
}

+ (void)deleteHunterProfile:(HunterProfile *)profile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    [pdao removeProfileByName:profile.name];
}

+ (void)changeHunterProfile:(HunterProfile *)profile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    [pdao modifyProfile:profile];
}

+ (void)clearAllHunterProfile {
    ProfileDataAssistObject *pdao = [ProfileDataAssistObject getInstance];
    [pdao removeAllProfiles];
}

+ (NSData *)postDataTask {
    NSString *host = @"http://mhp3wiki.duowan.com";
    NSString *httpBodyStr = @"name=dlfkid&password=123456";
    NSData *httpBody = [httpBodyStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *hostURL = [NSURL URLWithString:host];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:hostURL];
    [postRequest setHTTPBody:httpBody];
    [postRequest setHTTPMethod:@"POST"];
    __block NSData *dataReceived;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *postTask = [session dataTaskWithRequest:postRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            dataReceived = data;
        });
    }];
    [postTask resume];
    if(dataReceived){
        return dataReceived;
    }else{
        return nil;
    }
}

+ (NSURL *)getWebImageURL {
    NSString *host = @"http://www.51work6.com/service/download.php";
    NSString *httpBodyStr = @"?email=dlfkid@gmail.com&FileName=test1.jpg";
    NSString *stringURL = [host stringByAppendingString:httpBodyStr];
    NSURL *webImageURL = [NSURL URLWithString:stringURL];
    return webImageURL;
}

@end
