//
//  QuestDetailTableViewController.h
//  
//
//  Created by Ivan_deng on 2017/3/13.
//
//

#import <UIKit/UIKit.h>

@interface QuestDetailTableViewController : UITableViewController

@property(nonatomic,strong) NSMutableArray *QuestArray;
@property(nonatomic,assign) int missionType;
@property(nonatomic,assign) int starNum;

@end
