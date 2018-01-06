//
//  MonsterDetailViewController.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/24.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "MonsterDetailViewController.h"

#define SCREENWIDTH self.view.frame.size.width
#define GAPSPACE 30
#define ImageViewHeight 200
#define TOPVIEW 64
#define TABBARHEIGHT 48


@interface MonsterDetailViewController ()<UIScrollViewDelegate>


@end

@implementation MonsterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:true];
    UIImageView *imageView = [self imageViewWithMonsterPic];
    UILabel *briefLabel = [self labelWithContent];
    briefLabel.tag = 1002;
    
    [self.view addSubview:imageView];
    [self.view addSubview:briefLabel];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(MHPtopEdgeInset)).inset(3 * MHPstatusbar);
        make.left.right.mas_equalTo(0).inset(MHPstatusbar);
        make.height.equalTo(@200);
    }];
    
    [briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).inset(MHPstatusbar);
        make.left.right.equalTo(@0).inset(MHPnavigationbar);
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
        make.bottom.equalTo(@0);
    }];
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
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (UIImageView *)imageViewWithMonsterPic {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    UIImage *image = [UIImage imageNamed:self.monsterDetail.pic];
    imageView.image = image;
    return imageView;
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
