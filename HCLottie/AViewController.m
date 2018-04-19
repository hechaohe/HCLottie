//
//  AViewController.m
//  HCLottie
//
//  Created by hc on 2018/4/18.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "AViewController.h"

@interface AViewController ()
@property (nonnull, strong) UIButton *button1;
@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button1 setTitle:@"Show Transition B" forState:UIControlStateNormal];
    [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button1.backgroundColor = [UIColor colorWithRed:16.f/255.f
                                                   green:122.f/255.f
                                                    blue:134.f/255.f
                                                   alpha:1.f];
    self.button1.layer.cornerRadius = 7;
    
    [self.button1 addTarget:self action:@selector(_close) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor colorWithRed:200.f/255.f
                                                green:66.f/255.f
                                                 blue:72.f/255.f
                                                alpha:1.f];
    [self.view addSubview:self.button1];
    
    
}


- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    CGRect b = self.view.bounds;
    CGSize buttonSize = [self.button1 sizeThatFits:b.size];
    buttonSize.width += 20;
    buttonSize.height += 20;
    CGRect buttonRect;
    buttonRect.origin.x = b.origin.x + rintf(0.5f * (b.size.width - buttonSize.width));
    buttonRect.origin.y = b.origin.y + rintf(0.5f * (b.size.height - buttonSize.height));
    buttonRect.size = buttonSize;
    self.button1.frame = buttonRect;
    
    
}
- (void)_close {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}






















@end
