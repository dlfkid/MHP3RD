//
//  SlideViewController.h
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"
#import "MainViewController.h"

@interface SlideViewController : UIViewController

@property(nonatomic,strong) MainViewController *delegate;

@end
