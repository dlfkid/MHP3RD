//
//  MapDetailViewController.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/13.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "MapDetailViewController.h"

// Helpers
#import <Masonry/Masonry.h>
#import <iOSDeviceScreenAdapter/DeviceScreenAdaptor.h>
#import "MHPLogger.h"

@interface MapDetailViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation MapDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    self.scrollerView.backgroundColor = [UIColor whiteColor];
    self.scrollerView.delegate = self;
    UIImage *mapImage = [UIImage imageNamed:_detailMapName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.image = mapImage;
    [imageView setTag:100];
    self.scrollerView.contentSize = mapImage.size;
    [self.scrollerView setMaximumZoomScale:2];
    [self.scrollerView setMinimumZoomScale:1.5];
    [self addSwipeDownGesture];
    [self.view addSubview:self.scrollerView];
    [self.scrollerView addSubview:imageView];

    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 60) / 2, [UIScreen mainScreen].bounds.size.height - 130, 60, 60);
    [self.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonDidTappedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];

    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];

    [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.closeButton.mas_bottom);
    }];

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

    self.scrollerView.zoomScale = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return [self.view viewWithTag:100];
}

#pragma mark - force touch gesture

- (void)addSwipeDownGesture {
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownAction:)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [_scrollerView addGestureRecognizer:swipeDown];
}

- (void)swipeDownAction:(id)sender {
    MHPLog(@"double tapped");
    [self.closeButton removeFromSuperview];
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Actions

- (void)closeButtonDidTappedAction {
    [self.closeButton removeFromSuperview];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
