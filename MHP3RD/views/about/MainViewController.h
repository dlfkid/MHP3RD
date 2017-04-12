//
//  MainViewController.h
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"

@class AboutViewController;
@class SlideViewController;
@interface MainViewController : UIViewController

@property(nonatomic,strong) AboutViewController *fatherView;
@property(nonatomic,strong) UIScrollView *basicScroll;
@property(nonatomic,strong) SlideViewController * slider;

@end
