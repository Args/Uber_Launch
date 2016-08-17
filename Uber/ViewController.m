//
//  ViewController.m
//  Uber
//
//  Created by tih on 16/8/16.
//  Copyright © 2016年 TOSHIBA. All rights reserved.
//

#import "ViewController.h"
#import "UberView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UberView *uber = [[UberView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    uber.center =self.view.center;
    [self.view addSubview:uber];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
