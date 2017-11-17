//
//  NSThreadDemoViewController.m
//  MultithreadingDemo
//
//  Created by Neil Zhang on 2017/11/17.
//  Copyright © 2017年 inspur. All rights reserved.
//

#import "NSThreadDemoViewController.h"

@interface NSThreadDemoViewController ()

@end

@implementation NSThreadDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)dynamicCreateThread:(id)sender {
    NSLog(@"current thread:%@",[NSThread currentThread]);
    NSThread *dynamicThread =
        [[NSThread alloc]initWithTarget:self
                               selector:@selector(downloadImage:)
                                 object:nil];
    [dynamicThread setThreadPriority:1.0];
    [dynamicThread start];
}

- (void)downloadImage:(id)sender
{
    NSLog(@"current thread:%@",[NSThread currentThread]);
    //http://pic.sc.chinaz.com/files/pic/pic9/201303/xpic10458.jpg
    //http://img.sc115.com/uploads/sc/jpgs/05/xpic6813_sc115.com.jpg
    NSURL *imageURL = [NSURL URLWithString:@"http://img.sc115.com/uploads/sc/jpgs/05/xpic6813_sc115.com.jpg"];
    UIImage *image =
        [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:imageURL]];
    [self performSelectorOnMainThread:@selector(refreshImage:)
                               withObject:image
                            waitUntilDone:YES];
}

- (void)refreshImage:(UIImage *)image
{
    if (!image) {
        NSLog(@"There is no image data.");
    }else{
        [self.imageView setImage:image];
    }
    [NSTimer scheduledTimerWithTimeInterval:2.0f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self.imageView setImage:nil];
    }];
}

- (IBAction)staticCreateThread:(id)sender
{
    [NSThread detachNewThreadWithBlock:^{
        [self downloadImage:nil];
    }];
}

- (IBAction)implicitCreateThread:(id)sender
{
    [self performSelectorInBackground:@selector(downloadImage:) withObject:nil];
}
@end
