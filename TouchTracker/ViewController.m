//
//  ViewController.m
//  TouchTracker
//
//  Created by Neil Zhang on 2017/8/11.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "ViewController.h"
#import "NZDrawView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    self.view = [[NZDrawView alloc]initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
