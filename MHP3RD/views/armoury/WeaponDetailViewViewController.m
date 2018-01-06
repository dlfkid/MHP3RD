//
//  WeaponDetailViewViewController.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/23.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "WeaponDetailViewViewController.h"

#import <Masonry/Masonry.h>

#define SCREENWIDTH self.view.frame.size.width

@interface WeaponDetailViewViewController ()<UIScrollViewDelegate,UITextViewDelegate>

@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UIScrollView *textScroll;


@end

@implementation WeaponDetailViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.textScroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_textScroll];
    [_textScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _textScroll.delegate = self;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:self.weaponInfo.pic];
    imageView.tag = 101;
    [_textScroll addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.left.right.equalTo(@0);
        make.height.mas_equalTo(300);
    }];
    UILabel *labelText = [self configureTextView];
    [_textScroll addSubview:labelText];
    [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(@0);
        make.top.equalTo(imageView.mas_bottom).inset(MHPstatusbar);
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
