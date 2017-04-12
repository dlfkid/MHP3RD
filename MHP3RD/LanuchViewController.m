//
//  LanuchViewController.m
//  MHP3RD
//
//  Created by Ivan_deng on 2017/3/29.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "LanuchViewController.h"


@interface LanuchViewController ()

@end

@implementation LanuchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    UIImage *image =[UIImage imageNamed:@"launchScreen"];
    imageView.image = image;
    [self.view addSubview:imageView];
    sleep(5);
    [self dismissViewControllerAnimated:true completion:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
