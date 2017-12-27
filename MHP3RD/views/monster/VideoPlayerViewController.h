//
//  VideoPlayerViewController.h
//  MHP3RD
//
//  Created by Ivan_deng on 2017/12/3.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayer;
@class AVPlayerItem;
@class AVPlayerLayer;

@interface VideoPlayerViewController : UIViewController

@property(nonatomic,strong) AVPlayer *videoController;
@property(nonatomic,strong) AVPlayerItem *videoInfo;
@property(nonatomic,strong) AVPlayerLayer *videoFrame;
@property(nonatomic,strong) UIImageView *videoPlayerView;
@property(nonatomic,assign) CGFloat maxDuration;
@property(nonatomic,strong) UIButton *playerButton;

- (instancetype)initWithAVPlayer:(UIImage *)placeHolder;

@end
