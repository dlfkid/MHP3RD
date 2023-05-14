//
//  WeaponDetailViewViewController.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/23.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "WeaponDetailViewViewController.h"

#import <Masonry/Masonry.h>

@interface WeaponDetailViewViewController ()<UIScrollViewDelegate,UITextViewDelegate>

@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UIScrollView *textScroll;


@end

@implementation WeaponDetailViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self configureTextScroller];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = self.weaponInfo.name;
    [self.tabBarController.tabBar setHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - textView setting
- (UILabel *)configureTextView {
    UILabel *weaponText = [[UILabel alloc]init];
    weaponText.text = self.weaponInfo.brief;
    weaponText.textAlignment = NSTextAlignmentLeft;
    weaponText.font = [UIFont systemFontOfSize:16];
    weaponText.numberOfLines = 0;
    weaponText.lineBreakMode = NSLineBreakByTruncatingTail;
    return weaponText;
}


#pragma mark - scrollerView setting
- (void)configureTextScroller {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:self.weaponInfo.pic];
    imageView.tag = 101;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(MHPscreenWidth());
        make.height.mas_equalTo(250);
        make.top.mas_equalTo(0);
    }];
    self.textScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _textScroll.delegate = self;
    [self.view addSubview:_textScroll];
    [self.textScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom);
    }];
    UILabel *labelText = [self configureTextView];
    [_textScroll addSubview:labelText];
    [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(MHPscreenWidth() - 2 * MHPgap);
        make.top.equalTo(imageView.mas_bottom).mas_offset(MHPgap);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(-MHPgap).mas_offset(self.view.safeAreaInsets.bottom);
        } else {
            make.bottom.mas_equalTo(-MHPgap);
        }
    }];
    [_textScroll setContentSize:CGSizeMake(MHPscreenWidth(), MHPscreenHeight())];
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
