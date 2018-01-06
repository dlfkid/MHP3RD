//
//  MoreDetailViewController.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/14.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#define IMAGEVIEWHEIGHT 160
#define TITLELABELHEIGHT 80
#define TOPVIEW 64
#define GAP 10

#import "MoreDetailViewController.h"

#import <Masonry/Masonry.h>

@interface MoreDetailViewController ()<UIScrollViewDelegate>

@end

@implementation MoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if(self.questDetail){
        [self configurePicImageView];
        [self configureAdviceView];
    }
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"QuestDetail";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configurePicImageView {
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = self.questDetail.questName;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MHPtopEdgeInset);
        make.centerX.equalTo(@0);
        make.width.mas_equalTo(MHPscreenWidth());
    }];;

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    UIImage *questPic = [UIImage imageNamed:self.questDetail.questPic];
    imageView.image = questPic;
    imageView.tag = 100;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [scroll setContentSize:questPic.size];
    scroll.delegate = self;
    scroll.maximumZoomScale = 1;
    scroll.minimumZoomScale = 1;
    
    [scroll addSubview:imageView];
    [self.view addSubview:scroll];
    
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MHPtopEdgeInset + MHPlabelHeight);
        make.left.right.centerX.equalTo(@0);
        make.height.equalTo(@180);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
        make.centerX.equalTo(@0);
        make.height.equalTo(scroll);
    }];
}

- (void)configureAdviceView {
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectZero];
    text.numberOfLines = 0;
    text.font = [UIFont systemFontOfSize:16];
    text.layer.cornerRadius = 5;
    text.textAlignment = NSTextAlignmentCenter;
    text.text = self.questDetail.questBrief;
    [self.view addSubview:text];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset(MHPtabbar);
        make.centerX.left.right.equalTo(@0);
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return [self.view viewWithTag:100];
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
