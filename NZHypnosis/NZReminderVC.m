//
//  NZReminderVC.m
//  NZHypnosis
//
//  Created by Neil Zhang on 2017/8/3.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZReminderVC.h"
#import <UIKit/UIKit.h>

@interface NZReminderVC ()

@property (nonatomic,weak) IBOutlet UIDatePicker *datePicker;

- (IBAction)addReminder:(id)sender;

@end

@implementation NZReminderVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Reminder";
        self.tabBarItem.image = [UIImage imageNamed:@"Time"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:60]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addReminder:(id)sender{
    NSDate *date = self.datePicker.date;
    NSLog(@"%@",date);
    UILocalNotification *note = [[UILocalNotification alloc]init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

@end
