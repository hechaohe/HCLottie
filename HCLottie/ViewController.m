//
//  ViewController.m
//  HCLottie
//
//  Created by hc on 2018/4/18.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "ViewController.h"
#import <Lottie/Lottie.h>
#import "AViewController.h"
#import "CViewController.h"
@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) LOTAnimationView *topView;
@property (nonatomic,strong) LOTAnimationView *BView;
@property (nonatomic,strong) LOTAnimationView *CView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Twitter" style:UIBarButtonItemStyleDone target:self action:@selector(twitter)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStyleDone target:self action:@selector(push)];
    
    
    self.topView = [LOTAnimationView animationNamed:@"A"];
    self.topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.topView];
    
    self.BView = [LOTAnimationView animationNamed:@"B"];
    self.BView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.BView];
    
    self.CView = [LOTAnimationView animationNamed:@"C"];
    self.CView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.CView];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:_topView];
         [self.topView play];
    });
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:self.BView];
        [self.BView play];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:self.CView];
        [self.CView play];
    });
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.topView pause];
    [self.topView removeFromSuperview];
    [self.BView pause];
    [self.BView removeFromSuperview];
    [self.CView pause];
    [self.CView removeFromSuperview];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
//    [[UIApplication sharedApplication] statusBarFrame].size.height
    CGRect topViewRect = CGRectMake(0, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.bounds.size.width, self.view.bounds.size.height * .3);
    self.topView.frame = topViewRect;
    
    
    self.BView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.bounds.size.width, self.view.bounds.size.height * .3);
    
    self.CView.frame = CGRectMake(0, CGRectGetMaxY(self.BView.frame), self.view.bounds.size.width, self.view.bounds.size.height * .3);
    
    
}

- (void)twitter {
    
    [self.navigationController pushViewController:[CViewController new] animated:YES];
    
}

- (void)push {
    
    AViewController *vc = [[AViewController alloc] init];
    vc.transitioningDelegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
    
//    [self.navigationController pushViewController:[AViewController new] animated:YES];
    
    
}


#pragma mark -- View Controller Transitioning


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition1"
                                                                                                              fromLayerNamed:@"outLayer"
                                                                                                                toLayerNamed:@"inLayer"
                                                                                                     applyAnimationTransform:NO];
    return animationController;
    
    
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    
//    设置 present／dismiss controller 转场动画
//    在需要转场效果的 viewcontroller 中实现 UIViewControllerTransitioningDelegate代理中的下面两个方法，就可以设置 controller 转场动画了，animationName ：“vcTransition1” “vcTransition2” 就是 AE 导出的动画 json 文件名。
    
    LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition2"
                                                                                                              fromLayerNamed:@"outLayer"
                                                                                                                toLayerNamed:@"inLayer"
                                                                                                     applyAnimationTransform:NO];
    return animationController;
    
}

















@end
