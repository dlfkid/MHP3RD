//
//  AboutViewController.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/10.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "AboutViewController.h"
#import "ProfileAddViewController.h"
#import "ProfileViewController.h"
#import "HunterProfile.h"
#import "Communicator.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#define TABBARHEIGHT 48
#define SLIDEDISTANCE 130
#define LABELHEIGHT 40
#define LABELWIDTH 60
#define GAP 10
#define VIEWHEIGHT _basicScroll.frame.size.height
#define VIEWWIDTH _basicScroll.frame.size.width

@interface AboutViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate>

{
    UITableView *friendsTableView;
    NSMutableArray *allHunters;
    ProfileAddViewController *addProfile;
    UILabel *lonLabel;
    UILabel *latLabel;
}

@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,strong) MKMapView *map;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:false];
    [self.tabBarController.tabBar setTranslucent:false];
    //构建侧边栏和主栏
    _mainView = [[UIView alloc]init];
    _sliderView = [[UIView alloc]init];
    
    //将侧边栏和主栏添加到主界面，并把边框设置成一样。
    [self.view addSubview:_mainView];
    _mainView.tag = 101;
    [_mainView setFrame:self.view.bounds];
    
    [self.view addSubview:_sliderView];
    _sliderView.tag = 102;
    [_sliderView setFrame:self.view.bounds];
    //将主栏设置为默认显示
    [self.view bringSubviewToFront:_mainView];
    
    [self addSwipeGesture];
    
    //set up slider
    [self setBackgroundImage];
    [self configureButtons];
    //set up mainview
    [self configureBasicScroll];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"ABOUT";
    [self.tabBarController.tabBar setHidden:false];
    [self configureGpsLocationManager];
    allHunters = [Communicator getAllHunterProfile];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - add swipe gesture

//在主界面添加手势
- (void)addSwipeGesture {
    UISwipeGestureRecognizer *swipeR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    [swipeR setDirection:UISwipeGestureRecognizerDirectionRight];
    [_mainView addGestureRecognizer:swipeR];
    
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    [swipeL setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_mainView addGestureRecognizer:swipeL];
}
//根据手势类型执行边栏显示或隐藏
- (void)swipeGesture:(UISwipeGestureRecognizer *)sender {
    CALayer *layer = _mainView.layer;
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 20.0;
    if(sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self showSlideView];
    }else if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self hideSlideView];
    }
}
//显示或隐藏的方法
- (void)showSlideView {
    //显示边栏要首先调用否则会出现白底
    [_sliderView setHidden:false];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    if (_mainView.frame.origin.x == self.view.frame.origin.x || _mainView.frame.origin.x  == -200) {
        [_mainView setFrame:CGRectMake(_mainView.frame.origin.x + SLIDEDISTANCE, _mainView.frame.origin.y, _mainView.frame.size.width, _mainView.frame.size.height)];
    }
    [UIView commitAnimations];
}

- (void)hideSlideView {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    if (_mainView.frame.origin.x == self.view.frame.origin.x + SLIDEDISTANCE) {
        [_mainView setFrame:CGRectMake(_mainView.frame.origin.x - SLIDEDISTANCE, _mainView.frame.origin.y, _mainView.frame.size.width, _mainView.frame.size.height)];
    }
    [UIView commitAnimations];
    //隐藏边栏要在最后调用否则会露出白底
    //不需要这句
    //[[_slideController view] setHidden:true];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - sliders
- (void)setBackgroundImage {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, self.view.frame.size.height - 48 - 64)];
    [imageView setImage:[UIImage imageNamed:@"cat_bg"]];
    [_sliderView addSubview:imageView];
}


- (void)configureButtons {
    NSArray * titles = @[@"工会名片",@"猎友",@"导航",@"数据库",@"关于"];
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
        [_sliderView addSubview:label];
        [_sliderView addSubview:button];
    }
}

- (void)buttonTouchDown:(UIButton *)sender {
    viewType type = (int)sender.tag - 100;
    [self changeMainViewContentWithType:type];
    NSLog(@"Button tapped");
}

#pragma mark - MainViews

- (void)configureBasicScroll {
    _basicScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TABBARHEIGHT)];
    _basicScroll.contentSize = CGSizeMake(_basicScroll.frame.size.width, _basicScroll.frame.size.height * 5);
    _basicScroll.pagingEnabled = true;
    _basicScroll.delegate = self;
    [_basicScroll setBounces:false];
    [_mainView addSubview:_basicScroll];
    [_basicScroll setContentOffset:CGPointMake(0, 0)];
    [self configureHunterProfile];
    [self configureFrieds];
    [self configureGPSLocation];
    [self configureOfficialSite];
    [self configureAbout];
    [self addNotificationCenter];
}

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
    UILabel *Notes = [[UILabel alloc]initWithFrame:CGRectMake((VIEWWIDTH - 150)/2, 64 + 20, 150, 64)];
    Notes.backgroundColor = [UIColor clearColor];
    Notes.textAlignment = NSTextAlignmentCenter;
    Notes.numberOfLines = 0;
    Notes.text = @"无工会名片\n点击添加";
    Notes.font = [UIFont systemFontOfSize:20];
    Notes.textColor = [UIColor whiteColor];
    [hunterProfile addSubview:Notes];
    [_basicScroll addSubview:hunterProfile];
}

- (void)configureFrieds {
    UIView *friends = [[UIView alloc]initWithFrame:CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, VIEWHEIGHT)];
    friends.backgroundColor = [UIColor orangeColor];
    friends.tag = 1;
    friendsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT) style:UITableViewStylePlain];
    friendsTableView.delegate = self;
    friendsTableView.dataSource = self;
    [friendsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"friends"];
    [friendsTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"friendsHeader"];
    [friends addSubview:friendsTableView];
    [_basicScroll addSubview:friends];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [friendsTableView setEditing:editing animated:true];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath, nil];
    HunterProfile *hunter = allHunters[indexPath.row];
    [Communicator deleteHunterProfile:hunter];
    [allHunters removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(_basicScroll.contentOffset.y == self.view.frame.size.height) {
        [self.navigationController.navigationItem.rightBarButtonItem setAccessibilityElementsHidden:false];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return allHunters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friends" forIndexPath:indexPath];
    HunterProfile *hunterProfile = allHunters[indexPath.row];
    cell.textLabel.text = hunterProfile.name;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"我的朋友";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HunterProfile *hunter = allHunters[indexPath.row];
    ProfileViewController *profile = [[ProfileViewController alloc]init];
    profile.hunterInfo = hunter;
    [self.navigationController pushViewController:profile animated:true];
    [self.tabBarController.tabBar setHidden:true];
}

- (void)configureGPSLocation {
    UIView *GPSLocation = [[UIView alloc]initWithFrame:CGRectMake(0, VIEWHEIGHT * 2, VIEWWIDTH, VIEWHEIGHT)];
    GPSLocation.backgroundColor = [UIColor whiteColor];
    GPSLocation.tag = 2;
    self.map = [self configureMapKitView];
    [GPSLocation addSubview:self.map];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((VIEWWIDTH - 2 * LABELWIDTH)/2, VIEWHEIGHT/2 + GAP, 2 * LABELWIDTH, LABELHEIGHT)];
    titleLabel.text = @"我的位置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [GPSLocation addSubview:titleLabel];
    lonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.frame.origin.y + LABELHEIGHT, VIEWWIDTH, LABELHEIGHT)];
    latLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, lonLabel.frame.origin.y + LABELHEIGHT + GAP, VIEWWIDTH , LABELHEIGHT)];
    lonLabel.textAlignment = NSTextAlignmentCenter;
    latLabel.textAlignment = NSTextAlignmentCenter;
    lonLabel.text = @"经度:";
    latLabel.text = @"纬度:";
    [GPSLocation addSubview:lonLabel];
    [GPSLocation addSubview:latLabel];
    [_basicScroll addSubview:GPSLocation];
}

- (void)configureOfficialSite {
    UIView *officialSite = [[UIView alloc]initWithFrame:CGRectMake(0, VIEWHEIGHT * 3, VIEWWIDTH, VIEWHEIGHT)];
    officialSite.backgroundColor = [UIColor whiteColor];
    officialSite.tag = 3;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake((VIEWWIDTH - LABELWIDTH * 3)/2, (VIEWHEIGHT - LABELHEIGHT)/2, LABELWIDTH * 3, LABELHEIGHT)];
    title.text = @"多玩怪物猎人数据库";
    title.textAlignment = NSTextAlignmentCenter;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((VIEWWIDTH - 150)/2, title.frame.origin.y - GAP - 150, 150, 150)];
    imageView.image = [UIImage imageNamed:@"cat_icon"];
    UIButton *enter = [UIButton buttonWithType:UIButtonTypeSystem];
    enter.frame = CGRectMake((VIEWWIDTH - LABELWIDTH)/2, title.frame.origin.y + title.frame.size.height + GAP, LABELWIDTH, LABELHEIGHT);
    [enter setTitle:@"进入" forState:UIControlStateNormal];
    [enter addTarget:self action:@selector(enterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [officialSite addSubview:enter];
    [officialSite addSubview:imageView];
    [officialSite addSubview:title];
    [_basicScroll addSubview:officialSite];
}

- (void)configureAbout {
    UIView *About = [[UIView alloc]initWithFrame:CGRectMake(0, VIEWHEIGHT * 4, VIEWWIDTH, VIEWHEIGHT)];
    About.backgroundColor = [UIColor blueColor];
    About.tag = 4;
    [_basicScroll addSubview:About];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT)];
    imageView.image = [UIImage imageNamed:@"aboutBackGround"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((VIEWWIDTH - 180)/2, 80, 180, 300)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"怪物猎人攻略书\n\nAuther\n\n邓凌峰\n\nEmail\n\ndlfkid@163.com\n\nTel\n\n15112549197";
    [About addSubview:imageView];
    [imageView addSubview:label];
}

- (void)addNotificationCenter {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reciveProfileNotice:) name:@"ProfileAdded" object:nil];
}

- (void)reciveProfileNotice:(NSNotification *)notice {
    NSLog(@"Notic recived");
    allHunters = [Communicator getAllHunterProfile];
    [friendsTableView reloadData];
    [self configureHunterProfile];
}


#pragma mark - Gps configure 
- (void)configureGpsLocationManager {
    NSLog(@"Requesting location");
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];
    [self.locationManager pausesLocationUpdatesAutomatically];
}

- (MKMapView *)configureMapKitView {
    MKMapView *map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT/2)];
    map.mapType = MKMapTypeStandard;
    CLLocation *location = self.locationManager.location;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 3000, 3000);
    map.region = viewRegion;
    [map setShowsUserLocation:true];
    map.delegate = self;
    return map;
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    double longitude = userLocation.coordinate.longitude;
    double latitude = userLocation.coordinate.latitude;
    lonLabel.text = [NSString stringWithFormat:@"经度:%f",longitude];
    latLabel.text = [NSString stringWithFormat:@"纬度:%f",latitude];
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
    HunterProfile *lastHunter = [allHunters lastObject];
    int16_t currentID = lastHunter.ID;
    addProfile = [[ProfileAddViewController alloc]init];
    addProfile.ID = currentID + 1;
    UINavigationController *navProfile = [[UINavigationController alloc]initWithRootViewController:addProfile];
    [self presentViewController:navProfile animated:true completion:nil];
}

- (void)enterButtonAction:(UIButton *)sender {
    
}

@end
