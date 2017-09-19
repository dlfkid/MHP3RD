//
//  DonwnLoadTestViewController.m
//  MHP3RD
//
//  Created by Ivan_deng on 2017/9/18.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "DonwnLoadTestViewController.h"
#import "Communicator.h"

@interface DonwnLoadTestViewController ()

@property(nonatomic,strong) UIImageView *centralPic;
@property(nonatomic,strong) UIProgressView *progressView;

@end

@implementation DonwnLoadTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat topView = 64;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat PicSize = 100;
    
    UIImageView *pic = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth - PicSize)/2, topView, PicSize, PicSize)];
    _centralPic = pic;
    
    UIProgressView *progress = [[UIProgressView alloc]initWithFrame:CGRectMake(pic.frame.origin.x, pic.frame.origin.y + PicSize + 10, PicSize, 20)];
    _progressView = progress;
    
    [self.view addSubview:pic];
    [self.view addSubview:progress];
    
    [Communicator downlodaDataWithDelegateCOntroller:self];
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

#pragma mark - URLsession Download Task delegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"下载位置:%@",location);
    NSString *downLoadDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) objectAtIndex:0];
    
    NSString *downLoadPath = [downLoadDir stringByAppendingPathComponent:@"/test1.jpg"];
    NSURL *pathURL = [NSURL fileURLWithPath:downLoadPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if([fileManager fileExistsAtPath:downLoadPath]){
        [fileManager removeItemAtPath:downLoadPath error:&error];
        if(error){
            NSLog(@"删除文件失败: %@",error.localizedDescription);
        }
    }
    error = nil;
    if([fileManager moveItemAtURL:location toURL:pathURL error:&error]){
        NSLog(@"缓存到沙盒路径: %@",pathURL);
        UIImage *img = [UIImage imageWithContentsOfFile:downLoadPath];
        self.centralPic.image = img;
    }else{
        NSLog(@"复制文件到沙盒失败：%@",error.localizedDescription);
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float progressFloat = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
    [self.progressView setProgress:progressFloat animated:true];
    NSLog(@"接收：%lld 字节 总共:%lld 字节",totalBytesWritten,totalBytesExpectedToWrite);
}

@end
