//
//  MapScrollerViewController.m
//  MHP3Codex
//
//  Created by Ivan_deng on 2017/3/28.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#define PAGECONTROLWIDTH  30
#define PAGECONTROLHEIGHT 50
#import "MapScrollerViewController.h"

#import <Masonry/Masonry.h>
#import "MapDetailViewController.h"



@interface MapScrollerViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

{
    int current_index;
    BOOL isLast;
    NSArray *mapNames;
    NSArray *mapDetail;
    NSArray *mapTitle;
}

@property(nonatomic,strong) UIScrollView *scroller;
@property(nonatomic,strong) UIPageControl *pageController;


@end

@implementation MapScrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self configureScroller];
    [self configurePageControl];
    [self addGestrueSwipeUp];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - configure UI

- (void)configureScroller {
    //scroller frame
    self.scroller = [[UIScrollView alloc]initWithFrame:CGRectZero];
    self.scroller.contentSize = CGSizeMake(MHPscreenWidth() * mapNames.count, MHPscreenHeight());
    //NSLog(@"scrollview size: %f,%f \n content size %f,%f",_scroller.frame.size.width,_scroller.frame.size.height,_scroller.contentSize.width,_scroller.contentSize.height);
    _scroller.delegate = self;
    _scroller.pagingEnabled = true;
    [_scroller setAlwaysBounceHorizontal:true];
    [_scroller setMaximumZoomScale:1];
    [_scroller setShowsVerticalScrollIndicator:false];
    [_scroller setShowsHorizontalScrollIndicator:false];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.navigationItem.title = mapTitle[0];
    [self.view addSubview:_scroller];
    [self.scroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    for(int i = 0; i < mapNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor yellowColor];
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * MHPscreenWidth(), 0, MHPscreenWidth(), MHPscreenHeight())];
        [self.scroller addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(i * MHPscreenWidth()));
            make.width.mas_equalTo(MHPscreenWidth());
            make.height.mas_equalTo(MHPscreenHeight());
        }];
        imageView.image = [UIImage imageNamed:mapNames[i]];
        imageView.contentMode = UIViewContentModeScaleToFill;
    }
    _scroller.contentOffset = CGPointMake(MHPscreenWidth(), 0);
}

- (void)configurePageControl {
    _pageController = [[UIPageControl alloc]initWithFrame:CGRectMake((self.view.frame.size.width - PAGECONTROLWIDTH)/2, self.view.frame.size.height - MHPgap, PAGECONTROLWIDTH, PAGECONTROLHEIGHT)];
    [_pageController setBackgroundColor:[UIColor clearColor]];
    _pageController.alpha = 0.75f;
    _pageController.numberOfPages = mapNames.count;
    _pageController.tintColor = [UIColor lightGrayColor];
    _pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
    [_pageController addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
    [_scroller addSubview:_pageController];
}

- (void)pageControlAction:(UIPageControl *)sender {
    [_scroller setContentOffset:CGPointMake(self.view.frame.size.width * sender.currentPage, 0) animated:true];
}

#pragma mark - load data

- (void)loadData {
    mapNames = @[@"mapDongtuCover",@"mapXiliuCover",@"mapGudaoCover",@"mapShuimolinCover",@"mapShayuanCover",@"mapHuoshanCover",@"mapDongtuCover",@"mapXiliuCover"];
    mapDetail = @[@"xiliu",@"gudao",@"shuimolin",@"shayuan",@"huoshan",@"dongtu"];
    mapTitle = @[@"溪流",@"孤岛",@"水没林",@"沙原",@"火山",@"冻土"];
}

#pragma mark - scroller delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint currentOffset = scrollView.contentOffset;
    current_index = currentOffset.x / self.view.frame.size.width;
    if(current_index == 0) {
        [scrollView setContentOffset:CGPointMake((mapNames.count - 2) * self.view.frame.size.width, 0)];
        _pageController.currentPage = mapNames.count - 1;
    }else if (current_index == mapNames.count - 1) {
        [scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
        _pageController.currentPage = 1;
    }
    switch (current_index) {
        case 0:
            self.navigationItem.title = mapTitle[5];
            break;
        case 7:
            self.navigationItem.title = mapTitle[0];
            break;
        default:
            self.navigationItem.title = mapTitle[current_index-1];
            break;
    }
}

#pragma mark - add Gesture
- (void)addGestrueSwipeUp {
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUpAction:)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.scroller addGestureRecognizer:swipeUp];
}

- (void)swipeUpAction:(UIGestureRecognizer *)sender {
    NSString *tempMapName;
    switch (current_index) {
            case 0:
            tempMapName = mapDetail[5];
            break;
        case 7:
            tempMapName = mapDetail[0];
            break;
        default:
            tempMapName = mapDetail[current_index-1];
            break;
    }
    
    MapDetailViewController *detail = [[MapDetailViewController alloc]init];
    detail.detailMapName = tempMapName;
    NSLog(@"%@",tempMapName);
    [self presentViewController:detail animated:true completion:nil];
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
