//
//  WebViewController.m
//  MHP3RD
//
//  Created by Ivan_deng on 2017/9/15.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong) UIWebView *web;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self configureBackGesture];
    [self uiBuild];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = @"MHP3DataBase";
    [self.tabBarController.tabBar setTranslucent:false];
    [self.navigationController.navigationBar setTranslucent:false];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.tabBarController.tabBar setTranslucent:true];
    [self.navigationController.navigationBar setTranslucent:true];
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
#pragma mark - UIBuild
- (void)uiBuild {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _web = webView;
    _web.delegate = self;
    NSURL * url = [NSURL URLWithString:@"http://mhp3wiki.duowan.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_web loadRequest:request];
    [self.view addSubview:webView];
}


#pragma mark - GestureConfigure
- (void)configureBackGesture {
    UISwipeGestureRecognizer *swipeBack = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeBackAction:)];
    [swipeBack setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeBack];
}

- (void)swipeBackAction:(id)sender {
    NSLog(@"back to upper view");
    [self.navigationController popViewControllerAnimated:true];
}

@end
