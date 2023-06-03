//
//  MainViewController.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/27.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//


#define TABBARHEIGHT 48
#define VIEWHEIGHT _basicScroll.frame.size.height
#define VIEWWIDTH _basicScroll.frame.size.width
#import "MainViewController.h"
#import "Communicator.h"
#import "HunterProfile.h"
#import "ProfileAddViewController.h"
#import "MHPLogger.h"

@interface MainViewController ()<UIScrollViewDelegate>

{
    NSMutableArray *allHunters;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _basicScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TABBARHEIGHT)];
    _basicScroll.contentSize = CGSizeMake(_basicScroll.frame.size.width, _basicScroll.frame.size.height * 5);
    _basicScroll.pagingEnabled = true;
    _basicScroll.delegate = self;
    [_basicScroll setBounces:false];
    [self.view addSubview:_basicScroll];
    [_basicScroll setContentOffset:CGPointMake(0, 0)];
    [self configureHunterProfile];
    [self configureFrieds];
    [self configureGPSLocation];
    [self configureOfficialSite];
    [self configureAbout];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - scrollToTargetView
- (void)changeMainViewContentWithType:(viewType)type {
    NSLog(@"Selected view number :%d",type);
    CGFloat Y_axis = type * VIEWHEIGHT;
    CGPoint point = CGPointMake(0, Y_axis);
    [_basicScroll setContentOffset:point];
}

#pragma mark - setting up views
- (void)configureHunterProfile {
    UIView *hunterProfile = [[UIView alloc]initWithFrame:_basicScroll.frame];
    hunterProfile.backgroundColor = [UIColor redColor];
    hunterProfile.tag = 0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:hunterProfile.frame];
    imageView.image = [UIImage imageNamed:@"card"];
    [hunterProfile addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addProfileAction:)];
    [tap setNumberOfTapsRequired:1];
    [hunterProfile addGestureRecognizer:tap];
    
    if(allHunters.count == 0){
        UILabel *Notes = [[UILabel alloc]initWithFrame:CGRectMake((VIEWWIDTH - 150)/2, 64 + 20, 150, 64)];
        Notes.backgroundColor = [UIColor clearColor];
        Notes.textAlignment = NSTextAlignmentCenter;
        Notes.numberOfLines = 0;
        Notes.text = @"无工会名片\n点击添加";
        Notes.font = [UIFont systemFontOfSize:20];
        Notes.textColor = [UIColor whiteColor];
        [hunterProfile addSubview:Notes];
    }else{
        HunterProfile *myInfo = allHunters[0];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT)];
        title.textAlignment = NSTextAlignmentCenter;
        title.tintColor = [UIColor whiteColor];
        title.text = [NSString stringWithFormat:@"%@ %@ HR:%f",myInfo.name,myInfo.title,myInfo.HunterRank];
        [hunterProfile addSubview:title];
    }
    
    [_basicScroll addSubview:hunterProfile];
}

- (void)configureFrieds {
    UIView *friends = [[UIView alloc]initWithFrame:CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, VIEWHEIGHT)];
    friends.backgroundColor = [UIColor orangeColor];
    friends.tag = 1;
    [_basicScroll addSubview:friends];
}

- (void)configureGPSLocation {
    UIView *GPSLocation = [[UIView alloc]initWithFrame:CGRectMake(0, VIEWHEIGHT * 2, VIEWWIDTH, VIEWHEIGHT)];
    GPSLocation.backgroundColor = [UIColor yellowColor];
    GPSLocation.tag = 2;
    [_basicScroll addSubview:GPSLocation];
}

- (void)configureOfficialSite {
    UIView *officialSite = [[UIView alloc]initWithFrame:CGRectMake(0, VIEWHEIGHT * 3, VIEWWIDTH, VIEWHEIGHT)];
    officialSite.backgroundColor = [UIColor greenColor];
    officialSite.tag = 3;
    [_basicScroll addSubview:officialSite];
}

- (void)configureAbout {
    UIView *About = [[UIView alloc]initWithFrame:CGRectMake(0, VIEWHEIGHT * 4, VIEWWIDTH, VIEWHEIGHT)];
    About.backgroundColor = [UIColor blueColor];
    About.tag = 4;
    [_basicScroll addSubview:About];
}

- (void)addNotificationCenter {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reciveProfileNotice:) name:@"ProfileAdded" object:nil];
}

- (void)reciveProfileNotice:(NSNotification *)notice {
    NSLog(@"Notic recived");
    allHunters = [Communicator getAllHunterProfile];
    [self configureHunterProfile];
}

/*
#pragma mark - Navigation
 FRIEDS,
 GPSLOCATION,
 OFFICIALSITE,
 ABOUT,
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Button Action
- (void)addProfileAction:(UIButton *)sender {
    NSLog(@"Adding hunter Profile.");
    [self.fatherView.navigationController pushViewController:[ProfileAddViewController new] animated:true];
    [self.fatherView.tabBarController.tabBar setHidden:true];
}


@end
