//
//  QuestDetailTableViewController.m
//  
//
//  Created by Ivan_deng on 2017/3/13.
//
//

#import "QuestDetailTableViewController.h"
#import "MoreDetailViewController.h"
#import "Communicator.h"
#import "QuestInfo.h"

@interface QuestDetailTableViewController ()

@end

@implementation QuestDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view setFrame:[UIScreen mainScreen].bounds];
    [self settingUpRefreshControl];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"questInfo"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.QuestArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questInfo" forIndexPath:indexPath];
    QuestInfo *info = self.QuestArray[indexPath.row];
    cell.textLabel.text = info.questName;
    if(info.key){
        cell.textLabel.textColor = [UIColor redColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreDetailViewController *more = [[MoreDetailViewController alloc]init];
    QuestInfo *detail = self.QuestArray[indexPath.row];
    more.questDetail = detail;
    [self.navigationController pushViewController:more animated:YES];
}

#pragma mark - refreshControl

- (void)settingUpRefreshControl{
    UIRefreshControl *rc = [[UIRefreshControl alloc]init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"重新载加载"];
    [rc addTarget:self action:@selector(refreshing:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
}

- (void)refreshing:(id)refreshController{
    if(self.refreshControl.refreshing == true){
        NSLog(@"载入中……………………………………");
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"载入中……"];
        [Communicator refreshPlistData];
        self.QuestArray = [Communicator getQuestInfoMationForType:self.missionType andStars:self.starNum];
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"重新加载"];
        [self.tableView reloadData];
    }
}
@end
