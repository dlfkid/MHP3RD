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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _QuestArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questInfo" forIndexPath:indexPath];
    QuestInfo *info = self.QuestArray[indexPath.row];
    cell.textLabel.text = info.questName;
    if(info.key == YES){
        cell.textLabel.textColor = [UIColor redColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreDetailViewController *more = [[MoreDetailViewController alloc]init];
    QuestInfo *detail = self.QuestArray[indexPath.row];
    more.questDetail = detail;
    [self.navigationController pushViewController:more animated:true];
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
