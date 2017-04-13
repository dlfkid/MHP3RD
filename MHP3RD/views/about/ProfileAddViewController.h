//
//  ProfileAddViewController.h
//  MHP3RD
//
//  Created by Ivan_deng on 2017/3/29.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HunterProfile;
@interface ProfileAddViewController : UIViewController

@property(nonatomic,assign) int16_t ID;
@property(nonatomic,strong) HunterProfile * modifyHunterProfile;

@end
