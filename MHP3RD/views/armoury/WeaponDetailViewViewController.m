//
//  WeaponDetailViewViewController.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/23.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "WeaponDetailViewViewController.h"

#define SCREENWIDTH self.view.frame.size.width
#define GAPSPACE 10
#define NARROWGAP 20
#define VIEWHEIGHT 300

@interface WeaponDetailViewViewController ()<UIScrollViewDelegate,UITextViewDelegate>

@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UIScrollView *textScroll;


@end

@implementation WeaponDetailViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureTextScroller];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = self.weaponInfo.name;
    [self.tabBarController.tabBar setHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - scroll setting
- (void)configureScrollView {
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, VIEWHEIGHT)];
    [self.view addSubview:_scroll];
    _scroll.maximumZoomScale = 2;
    _scroll.minimumZoomScale = 1;
    _scroll.delegate = self;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:_scroll.frame];
    imageView.image = [UIImage imageNamed:self.weaponInfo.pic];
    imageView.tag = 101;
    [_scroll addSubview:imageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [self.scroll viewWithTag:101];
}

#pragma mark - textView setting
- (UILabel *)configureTextView {
    UILabel *weaponText = [[UILabel alloc]init];
    weaponText.text = self.weaponInfo.brief;
    weaponText.textAlignment = NSTextAlignmentCenter;
    weaponText.font = [UIFont systemFontOfSize:16];
    weaponText.numberOfLines = 0;
    weaponText.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maxSize = CGSizeMake(SCREENWIDTH - 2*GAPSPACE, MAXFLOAT);
    CGSize expectSize = [weaponText sizeThatFits:maxSize];
    weaponText.frame = CGRectMake(GAPSPACE,VIEWHEIGHT, expectSize.width, expectSize.height);
    return weaponText;
}


#pragma mark - scrollerView setting
- (void)configureTextScroller {
    self.textScroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_textScroll];
    _textScroll.delegate = self;
    _scroll.delegate = self;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, VIEWHEIGHT)];
    imageView.image = [UIImage imageNamed:self.weaponInfo.pic];
    imageView.tag = 101;
    [_textScroll addSubview:imageView];
    UILabel *labelText = [self configureTextView];
    
    [_textScroll addSubview:labelText];
    [_textScroll setContentSize:CGSizeMake(SCREENWIDTH, VIEWHEIGHT + labelText.frame.size.height + GAPSPACE)];
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
