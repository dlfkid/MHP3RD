//
//  VideoPlayerViewController.m
//  MHP3RD
//
//  Created by Ivan_deng on 2017/12/3.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

#define VIDEO_NAME @"composer.mp4"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self buildUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (instancetype)initWithAVPlayer:(UIImage *)placeHolder {
    self = [super init];
    self.videoController = [[AVPlayer alloc]init];
    self.videoFrame = [AVPlayerLayer playerLayerWithPlayer:_videoController];
    self.videoPlayerView = [[UIImageView alloc]initWithImage:placeHolder];
    return self;
}

- (void)buildUI {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat navBar = 44;
    CGFloat statusBar = 20;
    //设置播放窗口
    [self.videoPlayerView setFrame:CGRectMake(0, (navBar + statusBar), screenWidth, (screenHeight - navBar * 2))];
    [self.videoPlayerView.layer addSublayer:self.videoFrame];
    [self.view addSubview:_videoPlayerView];
    
    NSString *stringURL = [self applicationDocumentsDirectoryFile];
    
    NSURL *videoURL = [NSURL URLWithString:stringURL];
    
    self.videoInfo = [[AVPlayerItem alloc]initWithURL:videoURL];
    [self.videoController replaceCurrentItemWithPlayerItem:self.videoInfo];
    //设置播放按钮
    UIButton *play = [UIButton buttonWithType:UIButtonTypeSystem];
    [play setFrame:CGRectMake((screenWidth - 200)/2, (screenHeight - 100), 200, 100)];
    [play setTitle:@"播放" forState:UIControlStateNormal];
    self.playerButton = play;
    [play setHidden:true];
    [play addTarget:self action:@selector(beginVideoPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:play];
}

- (void)addObserverAndNotifications {
    //给playitem添加本控制器为KVO观察者，当playitem的status属性发生变化的时候触发方法。
    [self.videoInfo addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.videoInfo addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

    //KVO观察者观察到属性发生变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    AVPlayerItem *avItem = (AVPlayerItem *)object;
    if([keyPath isEqualToString:@"status"]) {
        //获取更改后的状态
        AVPlayerStatus currentStatus = [[change objectForKey:@"new"] intValue];
        if(currentStatus == AVPlayerStatusReadyToPlay) {
            CMTime duration = avItem.duration;//获取视频长度
            CGFloat videoDurationSeconds = CMTimeGetSeconds(duration);
            [self setMaxDuration:videoDurationSeconds];
            
            //显示播放按钮
            [self.playerButton setHidden:false];
            [self.videoController play];
        }else if (currentStatus == AVPlayerStatusFailed) {
            NSLog(@"Video play failed");
        }else {
            NSLog(@"Video player current status unknown.");
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    }
}

- (void)beginVideoPlay {
    [self.videoController play];
}

//该方法用于获得沙箱documents目录中NotesList.plist的完整路径
- (NSString *)applicationDocumentsDirectoryFile{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:VIDEO_NAME];
    return path;
}

@end
