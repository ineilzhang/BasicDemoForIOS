//
//  NZImageViewController.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/9/25.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZImageViewController.h"

@interface NZImageViewController ()

@end

@implementation NZImageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImageView *imageView =  (UIImageView *)self.view;
    imageView.image = self.image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

@end
