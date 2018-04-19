//
//  BViewController.m
//  HCLottie
//
//  Created by hc on 2018/4/18.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "BViewController.h"
#import <Lottie/Lottie.h>


@interface BViewController () <NSURLSessionDownloadDelegate>

@end

@implementation BViewController {
    NSURLSessionDownloadTask *_downloadTask;
    LOTAnimationView *_boatLoader;
    LOTPointInterpolatorCallback *_positionInterpolator;
}

- (void)createDownloadTask {
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/f/ff/Pizigani_1367_Chart_10MB.jpg"]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    _downloadTask = [session downloadTaskWithRequest:downloadRequest];
    [_downloadTask resume];
    
}

- (void)startDownload:(UIButton *)sender {
    sender.hidden = YES;
    [self createDownloadTask];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _boatLoader = [LOTAnimationView animationNamed:@"Boat_Loader"];
    _boatLoader.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _boatLoader.contentMode = UIViewContentModeScaleAspectFill;
    _boatLoader.frame = self.view.bounds;
    
    [self.view addSubview:_boatLoader];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Start Download" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = self.view.center;
    [button addTarget:self action:@selector(startDownload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    CGPoint screenCenter = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    CGPoint offScreenCenter = CGPointMake(screenCenter.x, -screenCenter.y);
    
    LOTKeypath *boatKeypath = [LOTKeypath keypathWithString:@"Boat"];
    
    CGPoint boatStartPoint = [_boatLoader convertPoint:screenCenter toKeypathLayer:boatKeypath];
    CGPoint boatEndPoint = [_boatLoader convertPoint:offScreenCenter toKeypathLayer:boatKeypath];
    
    _positionInterpolator = [LOTPointInterpolatorCallback withFromPoint:boatStartPoint toPoint:boatEndPoint];
     [_boatLoader setValueDelegate:_positionInterpolator forKeypath:[LOTKeypath keypathWithKeys:@"Boat", @"Transform", @"Position", nil]];
    
    _boatLoader.loopAnimation = YES;
    [_boatLoader playFromProgress:0 toProgress:0.5 withCompletion:nil];
    
    UIButton *closeButton_ = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton_ setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton_ addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton_];
    CGSize buttonSize = [closeButton_ sizeThatFits:self.view.bounds.size];
    closeButton_.frame = CGRectMake(10, 30, buttonSize.width, 50);
}
- (void)close {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}



- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    [_boatLoader pause];
    _boatLoader.loopAnimation = NO;
    _boatLoader.animationSpeed = 4;
    [_boatLoader playToProgress:0.5 withCompletion:^(BOOL animationFinished) {
        _boatLoader.animationSpeed = 1;
        [_boatLoader playToProgress:1 withCompletion:nil];
    }];
    
    
    @autoreleasepool {
        //下载成功调用此方法,
        NSFileManager *fileManager = [NSFileManager defaultManager];//文件管理
        NSURL *documentsDirectory=[NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/"]];
        NSURL *destinationPath = [documentsDirectory URLByAppendingPathComponent:@"10mb.jpg"];
        NSError *error;
        [fileManager removeItemAtURL:destinationPath error:NULL];//确保文件不在
        BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
        if(success){
            NSLog(@"success path:%@",destinationPath);
        }else{
            NSLog(@"error:%@",error);
        }
    }
    
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    _positionInterpolator.currentProgress = (CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite;
    
    
    double progress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    NSLog(@"progress is :%f",progress);
    
    
}













@end
