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

@interface MapDetailViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation MapDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    self.scrollerView.backgroundColor = [UIColor whiteColor];
    self.scrollerView.delegate = self;
    UIImage *map = [UIImage imageNamed:_detailMapName];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectZero];
    image.contentMode = UIViewContentModeScaleToFill;
    image.image = map;
    [image setTag:100];
    _scrollerView.contentSize = map.size;
    [_scrollerView setMaximumZoomScale:3];
    [_scrollerView setMinimumZoomScale:1.5];
    [self addSwipeDownGesture];
    [self.view addSubview:self.scrollerView];
    [self.scrollerView addSubview:image];
    CGFloat bottomIndicator = 0;
    CGFloat statusBarHeight = 20;
    switch ([DeviceScreenAdaptor screenType]) {
        case DeviceScreenType5_8:
        case DeviceScreenType6_1:
        case DeviceScreenType6_5:
            bottomIndicator = 34;
            statusBarHeight = 44;
            break;
            
        default:
            break;
    }
    
    [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomIndicator);
        make.top.mas_equalTo(statusBarHeight);
        make.left.right.equalTo(@0);

    }];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    NSLog(@"double tapped");
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
