//
//  ArmouryViewController.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/10.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "ArmouryViewController.h"
#import "WeaponDetailViewViewController.h"
#import "Communicator.h"
#import "WeaponInfo.h"

#define CELLIDENTITY @"cell"
#define HEADERIDENTITY @"header"

@interface ArmouryViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    int ROWNUM;
}

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *weaponList;

@end

@implementation ArmouryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configureTableView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:false];
    self.navigationItem.title = @"ARMOUTY";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure tableView

- (void)loadData {
    self.weaponList = [Communicator getWeaponInfomation];
    ROWNUM = (int)_weaponList.count;
}

- (void)configureTableView {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLIDENTITY];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:HEADERIDENTITY];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ROWNUM;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTITY forIndexPath:indexPath];
    WeaponInfo *weaponName = _weaponList[indexPath.row];
    cell.textLabel.text = weaponName.name;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setHighlighted:false];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeaponDetailViewViewController *weaponDetail = [[WeaponDetailViewViewController alloc]init];
    WeaponInfo *wep = self.weaponList[indexPath.row];
    weaponDetail.weaponInfo = wep;
    [self.navigationController pushViewController:weaponDetail animated:true];
    [self.tabBarController.tabBar setHidden:true];
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
