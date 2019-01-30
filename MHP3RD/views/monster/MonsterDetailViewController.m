//
//  MonsterDetailViewController.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/24.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "MonsterDetailViewController.h"
#import <iOSDeviceScreenAdapter/DeviceScreenAdaptor.h>


@interface MonsterDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *briefLabel;
@property (nonatomic, strong) UILabel *weaknessLabel;
@property (nonatomic, strong) UIImageView *monsterAvatar;

@end

@implementation MonsterDetailViewController

- (void)loadView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(width, height + 100);
    self.view = self.scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabBarController.tabBar setHidden:true];
    UIImageView *imageView = [self imageViewWithMonsterPic];
    UILabel *briefLabel = [self labelWithContent];
    briefLabel.tag = 1002;
    
    [self.view addSubview:imageView];
    [self.view addSubview:briefLabel];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MHPstatusbar * 2);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 20);
        make.height.equalTo(@200);
    }];
    
    [briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).inset(MHPstatusbar);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 20);
        make.centerX.equalTo(@0);
    }];
    
    imageView.tag = 1001;
    self.navigationItem.title = self.monsterDetail.name;
    NSString *weakness = self.monsterDetail.weak;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = weakness;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(briefLabel.mas_bottom).inset(MHPstatusbar);
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@(-20));
    }];
    
    self.briefLabel = briefLabel;
    self.weaknessLabel = label;
    self.monsterAvatar = imageView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = self.briefLabel.frame.size.height + self.monsterAvatar.frame.size.height + self.weaknessLabel.frame.size.height + MHPstatusbar * 5;
    self.scrollView.contentSize = CGSizeMake(width, height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - StringContent
- (UILabel *)labelWithContent {
    NSString *contentString = self.monsterDetail.atk;
    UILabel *label = [[UILabel alloc]init];
    label.text = contentString;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (UIImageView *)imageViewWithMonsterPic {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    UIImage *image = [UIImage imageNamed:self.monsterDetail.pic];
    imageView.image = image;
    return imageView;
}




@end
