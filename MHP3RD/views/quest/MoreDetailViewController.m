//
//  MoreDetailViewController.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/14.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#define IMAGEVIEWHEIGHT 200
#define TITLELABELHEIGHT 80
#define TOPVIEW 64
#define GAP 10

#import "MoreDetailViewController.h"

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
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, TOPVIEW, self.view.frame.size.width,TITLELABELHEIGHT)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = self.questDetail.questName;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IMAGEVIEWHEIGHT)];
    UIImage *questPic = [UIImage imageNamed:self.questDetail.questPic];
    imageView.image = questPic;
    imageView.tag = 100;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPVIEW +TITLELABELHEIGHT + GAP, self.view.frame.size.width, IMAGEVIEWHEIGHT)];
    [scroll setContentSize:questPic.size];
    scroll.delegate = self;
    scroll.maximumZoomScale = 2;
    scroll.minimumZoomScale = 1;
    [self.view addSubview:titleLabel];
    [scroll addSubview:imageView];
    [self.view addSubview:scroll];
}

- (void)configureAdviceView {
    UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(0,TOPVIEW + TITLELABELHEIGHT + GAP + IMAGEVIEWHEIGHT + GAP, [UIScreen mainScreen].bounds.size.width, 100)];
    [text setEditable:NO];
    text.layer.cornerRadius = 5;
    text.layer.borderWidth = 3;
    text.textAlignment = NSTextAlignmentCenter;
    text.text = self.questDetail.questBrief;
    [self.view addSubview:text];
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
