//
//  MonsterDetailViewController.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/24.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "MonsterDetailViewController.h"
#define SCREENWIDTH self.view.frame.size.width
#define GAPSPACE 30
#define ImageViewHeight 200
#define TOPVIEW 64
#define TABBARHEIGHT 48


@interface MonsterDetailViewController ()<UIScrollViewDelegate>

{
    UIScrollView *scrollerButton;
}

@end

@implementation MonsterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    UIImageView *imageView = [self imageViewWithMonsterPic];
    UILabel *briefLabel = [self labelWithContent];
    briefLabel.tag = 1002;
    scrollerButton = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollerButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollerButton];
    scrollerButton.delegate = self;
    [scrollerButton addSubview:imageView];
    [scrollerButton addSubview:briefLabel];
    [scrollerButton setContentSize:CGSizeMake(SCREENWIDTH, imageView.frame.size.height + briefLabel.frame.size.height + TOPVIEW)];
    imageView.tag = 1001;
    self.navigationItem.title = self.monsterDetail.name;
    NSString *weakness = self.monsterDetail.weak;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,[scrollerButton viewWithTag:1002].frame.size.height + ImageViewHeight, SCREENWIDTH, GAPSPACE * 2)];
    label.text = weakness;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [scrollerButton addSubview:label];
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
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maxSize = CGSizeMake(SCREENWIDTH - 2*GAPSPACE, MAXFLOAT);
    CGSize expectSize = [label sizeThatFits:maxSize];
    label.frame = CGRectMake(GAPSPACE,ImageViewHeight, expectSize.width, expectSize.height);
    return label;
}

- (UIImageView *)imageViewWithMonsterPic {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(GAPSPACE,0, SCREENWIDTH - 2*GAPSPACE, ImageViewHeight)];
    UIImage *image = [UIImage imageNamed:self.monsterDetail.pic];
    imageView.image = image;
    return imageView;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollerButton viewWithTag:1001];
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
