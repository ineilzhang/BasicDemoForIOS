//
//  NZChangeDateViewController.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/10.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZChangeDateViewController.h"


@interface NZChangeDateViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;



- (IBAction)backDetail:(id)sender;

@end

@implementation NZChangeDateViewController

- (void)viewWillAppear:(BOOL)animated{
//    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.pickDate = self.datePicker.date;
}


- (IBAction)backDetail:(id)sender {
//    __weak __typeof__(self) weakSelf = self;
//    if (self.pickDateBlk) {
//        self.pickDateBlk(weakSelf.datePicker.date);
//    }
    self.pickDate = self.datePicker.date;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
