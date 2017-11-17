//
//  GCDDemoViewController.m
//  MultithreadingDemo
//
//  Created by Neil Zhang on 2017/11/17.
//  Copyright © 2017年 inspur. All rights reserved.
//

#import "GCDDemoViewController.h"

@interface GCDDemoViewController ()

@end

@implementation GCDDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)downloadImage1
{
    NSURL *image1URL = [NSURL URLWithString:@"http://pic.sc.chinaz.com/files/pic/pic9/201303/xpic10458.jpg"];
    NSData *image1Data = [NSData dataWithContentsOfURL:image1URL];
    UIImage *image1 = [UIImage imageWithData:image1Data];
    return image1;
}

- (UIImage *)downloadImage2
{
    NSURL *image2URL = [NSURL URLWithString:@"http://img.sc115.com/uploads/sc/jpgs/05/xpic6813_sc115.com.jpg"];
    NSData *image2Data = [NSData dataWithContentsOfURL:image2URL];
    UIImage *image2 = [UIImage imageWithData:image2Data];
    return image2;
}

- (void)imageNil
{
    [NSTimer scheduledTimerWithTimeInterval:2.0f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self.firstImage setImage:nil];
        [self.secondImage setImage:nil];
    }];
}

- (IBAction)dispatchAsyncDemo:(id)sender {
    dispatch_queue_t myConcurrentQueue = dispatch_queue_create("com.inspur.neil.GCDDemo", 0);
    dispatch_async(myConcurrentQueue, ^{
        
    });
}

- (IBAction)dispatchSyncDemo:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image1 = [self downloadImage1];
        UIImage *image2 = [self downloadImage2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.firstImage setImage:image1];
            [self.secondImage setImage:image2];
            [self imageNil];
        });
    });
}

- (IBAction)dispatchAfterDemo:(id)sender {
}
- (IBAction)dispatchGroupDemo:(id)sender {
}

- (IBAction)dispatchBarrierAsync:(id)sender {
}

- (IBAction)dispatchBarrierAsyncDemo:(id)sender {
}

- (IBAction)dispatchOnceDemo:(id)sender {
}

- (IBAction)dispatchSemaphoreDemo:(id)sender {
}
@end
