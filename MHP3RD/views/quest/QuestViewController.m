//
//  QuestViewController.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/10.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "QuestViewController.h"
#import "QuestDetailTableViewController.h"
#import "QuestInfo.h"
#import "Communicator.h"

@interface QuestViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *sectionTitles;
    NSArray *villageTitles;
    NSArray *lowerTitiles;
    NSArray *upperTitiles;
}

@property(nonatomic,strong) UITableView *tabelView;

@end

@implementation QuestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDataSource];
    [self configureTableView];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:false];
    self.navigationItem.title = @"QUEST";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureTableView {
    self.tabelView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"titles"];
    [self.view addSubview:self.tabelView];
}

- (void)loadDataSource {
    sectionTitles = @[@"村长任务",@"集会所下位",@"集会所上位"];
    villageTitles = @[@"★",@"★★",@"★★★",@"★★★★",@"★★★★★",@"★★★★★★"];
    lowerTitiles = @[@"★",@"★★",@"★★★",@"★★★★",@"★★★★★"];
    upperTitiles = @[@"★★★★★★",@"★★★★★★★",@"★★★★★★★★"];
    
}

#pragma mark - tableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return villageTitles.count;
            break;
        case 1:
            return lowerTitiles.count;
            break;
        default:
            return upperTitiles.count;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return sectionTitles[0];
            break;
        case 1:
            return sectionTitles[1];
            break;
        default:
            return sectionTitles[2];
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titles" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = villageTitles[indexPath.row];
            break;
        case 1:
            cell.textLabel.text = lowerTitiles[indexPath.row];
            break;
        case 2:
            cell.textLabel.text = upperTitiles[indexPath.row];
        default:
            break;
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestDetailTableViewController *detail = [[QuestDetailTableViewController alloc]init];
    MHPLog(@"Getting %ldst level %ld star mission", (long)indexPath.section, indexPath.row);
    int starNum = (int)indexPath.row;
    int missionType = (int)indexPath.section;
    NSMutableArray *arr = [Communicator getQuestInfoMationForType:missionType andStars:starNum];
    detail.QuestArray = arr;
    detail.starNum = starNum;
    detail.missionType = missionType;
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
