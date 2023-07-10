//
//  MHPAboutViewController.m
//  MHP3RD
//
//  Created by LeonDeng on 2019/1/30.
//  Copyright © 2019 Ivan_deng. All rights reserved.
//

#import "MHPAboutViewController.h"

// Helpers
#import <Masonry/Masonry.h>
#import "MHPLogger.h"

@interface MHPAboutViewController ()

@end

@implementation MHPAboutViewController

- (void)loadView {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"aboutBackGround"];
    self.view = imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于作者";
    [self configureAbout];
}


- (void)configureAbout {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"怪物猎人攻略书\n\nAuther\n\nLeonDeng\n\nEmail\n\ndlfkid@163.com\n\nTel\n\n15112549197";
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.centerY.equalTo(@0);
    }];
}

@end
