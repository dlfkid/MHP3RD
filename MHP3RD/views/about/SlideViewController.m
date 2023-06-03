//
//  SlideViewController.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "SlideViewController.h"
#import "MHPLogger.h"

@interface SlideViewController ()

{
    NSArray *titles;
}

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    titles = @[@"工会名片",@"猎友",@"导航",@"数据库",@"关于"];
    [self setBackgroundImage];
    [self configureButtons];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBackgroundImage {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, self.view.frame.size.height - 48 - 64)];
    [imageView setImage:[UIImage imageNamed:@"cat_bg"]];
    [self.view addSubview:imageView];
}

#pragma mark - labels
- (void)configureButtons {
    for(int i = 0; i < titles.count; i++) {
        CGFloat labelWidth = 130;
        CGFloat labelHeight = 44;
        CGFloat topGap = labelHeight * 1;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,topGap + i * labelHeight, labelWidth, labelHeight)];
        label.text = titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        UIButton *button = [[UIButton alloc]initWithFrame:label.frame];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:label];
        [self.view addSubview:button];
    }
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
