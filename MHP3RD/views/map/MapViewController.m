//
//  MapViewController.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/10.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#define ITEMSIZE 150

#import "MapViewController.h"
#import "MapDetailViewController.h"
#import "CustomCollectionViewLayout.h"
#import "MHPLogger.h"

@interface MapViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CustomCollectionViewLayoutDelegate>

{
    int COL_NUM;
    int ROW_NUM;
    NSArray *mapName;
    NSArray *mapCover;
    CustomCollectionViewLayout *myLayout;
}

@property(nonatomic,strong)UICollectionView * mapCollectionView;
@property(nonatomic,strong)NSMutableArray *mapCollection;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMapCover];
    COL_NUM = (int)self.mapCollection.count;
    ROW_NUM = 1;
    self.view.backgroundColor = [UIColor yellowColor];
    
    CustomCollectionViewLayout *customLayout = [[CustomCollectionViewLayout alloc]init];
    customLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, [UIScreen mainScreen].bounds.size.height - 64 - 40 - 105);
    customLayout.scale = 0.85f;
    customLayout.delegate = self;
    myLayout = customLayout;
    self.mapCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:customLayout];
    self.mapCollectionView.backgroundColor = [UIColor whiteColor];
    self.mapCollectionView.delegate = self;
    self.mapCollectionView.dataSource = self;
    [self.mapCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"maps"];
    [self.view addSubview:self.mapCollectionView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"MAP";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewFlowLayout *)configureLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(ITEMSIZE, ITEMSIZE);
    //设置section内边距，这里设置为0.
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    return layout;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return ROW_NUM;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return COL_NUM;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.mapCollectionView dequeueReusableCellWithReuseIdentifier:@"maps" forIndexPath:indexPath];
    [cell.contentView setBackgroundColor:[UIColor redColor]];
    [cell.contentView addSubview:self.mapCollection[indexPath.section * COL_NUM + indexPath.row]];
    return cell;
}

- (void)loadMapCover {
    self.mapCollection = [NSMutableArray array];
    mapCover = @[@"mapXiliuCover",@"mapGudaoCover",@"mapShuimolinCover",@"mapShayuanCover",@"mapHuoshanCover",@"mapDongtuCover"];
    mapName = @[@"xiliu",@"gudao",@"shuimolin",@"shayuan",@"huoshan",@"dongtu"];
    for(int i = 0; i < mapCover.count; i++){
        UIImageView *cover = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width - 80, [UIScreen mainScreen].bounds.size.height - 64 - 40 - 105)];
        cover.image = [UIImage imageNamed:mapCover[i]];
        [self.mapCollection addObject:cover];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MapDetailViewController *detail = [[MapDetailViewController alloc]init];
    detail.detailMapName = mapName[indexPath.section * COL_NUM + indexPath.row];
    NSLog(@"mapName = %@",detail.detailMapName);
    [self.navigationController pushViewController:detail animated:true];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
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
