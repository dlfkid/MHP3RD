//
//  DonwnLoadTestViewController.m
//  MHP3RD
//
//  Created by Ivan_deng on 2017/9/18.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "DonwnLoadTestViewController.h"
#import "Communicator.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <SDWebImage/SDWebImageManager.h>

@interface DonwnLoadTestViewController ()

@property(nonatomic,strong) UIButton *clearButton;

@end

@implementation DonwnLoadTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self startDownloadWebImage];
    // Do any additional setup after loading the view.
}

- (UIImageView *)downloadImage {
    CGFloat topView = 64;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat PicSizeWidth = 200;
    CGFloat PicSizeHeight = 150;
    if(_downloadImage == nil) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth - PicSizeWidth)/2, topView, PicSizeWidth, PicSizeHeight)];
        imageView.backgroundColor = [UIColor yellowColor];
        _downloadImage = imageView;
        return _downloadImage;
    }else {
        return _downloadImage;
    }
}

- (UIButton *)clearButton {
    if(_clearButton == nil) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat buttonWidth = 120;
        CGFloat buttonHeight = 40;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((screenWidth - buttonWidth)/2, screenHeight - 200, buttonWidth, buttonHeight);
        button.titleLabel.text = @"清空图片缓存";
        _clearButton = button;
        
        [button addTarget:self action:@selector(clearWebImageCacheInSandBox) forControlEvents:UIControlEventTouchUpInside];
        return _clearButton;
    }
    else return _clearButton;
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

- (void)startDownloadWebImage {
    AFNetworkReachabilityManager *aFManager = [AFNetworkReachabilityManager sharedManager];
    if(aFManager.isReachableViaWiFi) {
        NSLog(@"Current network condition: WiFi");
        SDWebImageManager * sdManager = [SDWebImageManager sharedManager];
        [sdManager loadImageWithURL:[Communicator getWebImageURL] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            NSLog(@"图片下载中");
            if(receivedSize == expectedSize) {
                NSLog(@"图片下载完毕");
            }
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if(image) {
                self.downloadImage.image = image;
                [self.view addSubview:self.downloadImage];
            }else {
                NSLog(@"Download image failed.");
            }
        }];
        
    }else if(aFManager.isReachableViaWWAN) {
        NSLog(@"Current network condition: WWAN");
    }else {
        NSLog(@"Current network condition: Unreachable");
    }
}

- (void)clearWebImageCacheInSandBox {
    NSLog(@"清空缓存图片");
}

@end
