//
//  MapDetailViewController.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/13.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "MapDetailViewController.h"

@interface MapDetailViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation MapDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollerView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollerView.delegate = self;
    UIImage *map = [UIImage imageNamed:_detailMapName];
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    image.image = map;
    [image setTag:100];
    [_scrollerView addSubview:image];
    _scrollerView.contentSize = map.size;
    [_scrollerView setMaximumZoomScale:2];
    [_scrollerView setMinimumZoomScale:1];
    [self addSwipeDownGesture];
    [self.view addSubview:self.scrollerView];
    
    // Do any additional setup after loading the view.
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
