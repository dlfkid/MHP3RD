//
//  MonsterViewController.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/10.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "MonsterViewController.h"

#import <Masonry/Masonry.h>
#import "MonsterDetailViewController.h"

#define CELLIDENTITY @"monsterCell"
#define HEADERIDENTY @"monsterHeader"

#define ITEMSIZE 90

@interface MonsterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

{
    NSArray *monsterTypeName;
    int SECTION_NUM;
}
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation MonsterViewController

- (void)loadView {
    UIImageView *backGround = [self setupBackgroundImage];
    backGround.userInteractionEnabled = YES;
    self.view = backGround;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureReloadButton];
    [self configureCollectionView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:false];
    self.navigationItem.title = @"MONSTER";
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)setupBackgroundImage {
    UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card"] highlightedImage:nil];
    return background;
}

- (void)configureCollectionView {
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[self configureLayout]];
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELLIDENTITY];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERIDENTY];
    self.collectionView.dataSource = self;
    // self.collectionView.backgroundView = [self setupBackgroundImage];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alpha = 0.8;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UICollectionViewFlowLayout *)configureLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 40;
//    layout.sectionInset = UIEdgeInsetsMake(GAPSPACE, GAPSPACE, GAPSPACE, GAPSPACE);
    layout.itemSize = CGSizeMake(ITEMSIZE, ITEMSIZE);
    //设置item水平排列
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(MHPscreenWidth(), MHPtabbar);
    return layout;
}

- (void)loadDataSource {
    monsterTypeName = @[@"鸟龙种",@"牙兽种",@"牙龙种",@"海龙种",@"兽龙种",@"飞龙种",@"古龙种"];
    SECTION_NUM = (int)monsterTypeName.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return SECTION_NUM;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    MONSTERTYPE type = (int)section;
    return [Communicator getMonsterInfomattionForType:type].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MONSTERTYPE type = (int)indexPath.section;
    
    NSMutableArray *monsterArr = [Communicator getMonsterInfomattionForType:type];
    
    MonsterInfo *monsterInfo = monsterArr[indexPath.row];
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CELLIDENTITY forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:monsterInfo.pic];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.image = image;
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(imageView.superview);
    }];
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.tintColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    MONSTERTYPE monsterType = (int)indexPath.section;
    titleLabel.text = monsterTypeName[monsterType];
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERIDENTY forIndexPath:indexPath];
    header.backgroundColor = [UIColor whiteColor];
    [header addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titleLabel.superview);
    }];
    return header;
}

#pragma mark - reLoadButton

- (void)configureReloadButton {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refreshingCollectionView:)];
}

- (void)refreshingCollectionView:(UIBarButtonItem*)sender {
    [Communicator refreshMonsterData];
    [self.collectionView reloadData];
}

#pragma mark - pushView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MONSTERTYPE type = (int)indexPath.section;
    
    NSMutableArray *monsterArr = [Communicator getMonsterInfomattionForType:type];
    
    MonsterInfo *monsterInfo = monsterArr[indexPath.row];
    
    MonsterDetailViewController *detail = [[MonsterDetailViewController alloc]init];
    detail.monsterDetail = monsterInfo;
    
    [self.navigationController pushViewController:detail animated:true];
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
