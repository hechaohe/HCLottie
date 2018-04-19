//
//  CViewController.m
//  HCLottie
//
//  Created by hc on 2018/4/18.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "CViewController.h"
#import <Lottie/Lottie.h>
#import "BViewController.h"
@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Boat" style:UIBarButtonItemStyleDone target:self action:@selector(downloadBoat)];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    LOTAnimatedSwitch *toggle1 = [LOTAnimatedSwitch switchNamed:@"Switch"];
    
    /// On animation is 0.5 to 1 progress.
    [toggle1 setProgressRangeForOnState:0.5 toProgress:1];
    /// Off animation is 0 to 0.5 progress.
    [toggle1 setProgressRangeForOffState:0 toProgress:0.5];
    
    [toggle1 addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:toggle1];
    
    toggle1.bounds = CGRectMake(0, 0, 100, 40);
     toggle1.center = CGPointMake(CGRectGetMidX(self.view.bounds), 100);
    
    
    
    LOTAnimatedSwitch *heartIcon = [LOTAnimatedSwitch switchNamed:@"TwitterHeart"];
    heartIcon.backgroundColor = [UIColor brownColor];
    [heartIcon addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:heartIcon];
    
    heartIcon.bounds = CGRectMake(0, 0, 200, 200);
    heartIcon.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    lb.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 30);
    [self.view addSubview:lb];
    lb.text = @"hello world";
    lb.textAlignment = NSTextAlignmentCenter;
    
}

- (void)switchToggled:(LOTAnimatedSwitch *)animatedSwitch {
    NSLog(@"The switch is %@", (animatedSwitch.on ? @"ON" : @"OFF"));
}



- (void)downloadBoat {
    
    [self.navigationController pushViewController:[BViewController new] animated:YES];
    
}





@end
