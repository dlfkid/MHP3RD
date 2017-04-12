//
//  ProfileViewController.m
//  MHP3RD
//
//  Created by Ivan_deng on 2017/4/11.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "ProfileViewController.h"
#import "HunterProfile.h"

#define KEYBOARDHEIGHT 300
#define LABELHEIGHT 40
#define LABELWIDTH 60
#define GAP 10
#define TEXTFIELDWIDTH 150
#define NAVBAR 64
#define TABBAR 48
#define SCREENWIDTH self.view.frame.size.width
#define SCREENHEIGHT self.view.frame.size.height

@interface ProfileViewController ()

{
    UIScrollView *backGroundScroll;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    backGroundScroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [backGroundScroll setContentOffset:CGPointMake(0, - SCREENHEIGHT) animated:true];
    [backGroundScroll setContentSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT + KEYBOARDHEIGHT)];
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    background.image = [UIImage imageNamed:@"card2"];
    [self.view addSubview:backGroundScroll];
    [backGroundScroll addSubview:background];
    self.navigationItem.title = self.hunterInfo.name;
    [self ConfigureUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)ConfigureUI {
    NSArray *labelNames = @[@"名字",@" 称号",@"村任务",@"集会下",@"集会上",@"等级",@"简介"];
    NSMutableArray *labelCOntent = [NSMutableArray array];
    [labelCOntent addObject:_hunterInfo.name];
    [labelCOntent addObject:_hunterInfo.title];
    [labelCOntent addObject:[NSString stringWithFormat:@"%d",(int)_hunterInfo.questVillage]];
    [labelCOntent addObject:[NSString stringWithFormat:@"%d",(int)_hunterInfo.questGuildLow]];
    [labelCOntent addObject:[NSString stringWithFormat:@"%d",(int)_hunterInfo.questGuildHigh]];
    [labelCOntent addObject:[NSString stringWithFormat:@"%d",(int)_hunterInfo.HunterRank]];
    [labelCOntent addObject:_hunterInfo.selfIntroduce];
    for(int i = 0; i < labelNames.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,i * LABELHEIGHT,SCREENWIDTH,LABELHEIGHT * 3)];
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%@:%@",labelNames[i],labelCOntent[i]];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [backGroundScroll addSubview:label];
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
