//
//  NSOperationDmeoViewController.m
//  MultithreadingDemo
//
//  Created by Neil Zhang on 2017/11/17.
//  Copyright © 2017年 inspur. All rights reserved.
//

#import "NSOperationDmeoViewController.h"

@protocol DownloadImageDelegate <NSObject>

@required

- (void)refreshImageOnMain:(UIImage *)image;

@end

@interface DownloadImageOperation : NSOperation

@property (nonatomic,weak) id<DownloadImageDelegate> downloadImageDelegate;

@end

@implementation DownloadImageOperation

- (void)main
{
    if (self.isCancelled) {
        return;
    }
    NSURL *imageURL = [NSURL URLWithString:@"http://img.sc115.com/uploads/sc/jpgs/05/xpic6813_sc115.com.jpg"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    if (self.downloadImageDelegate && [self.downloadImageDelegate respondsToSelector:@selector(refreshImageOnMain:)]) {
        [(NSObject *)self.downloadImageDelegate performSelectorOnMainThread:@selector(refreshImageOnMain:) withObject:image waitUntilDone:YES];
    }
}

@end

@interface NSOperationDmeoViewController ()<DownloadImageDelegate>

@end

@implementation NSOperationDmeoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)useInvocationOperation:(id)sender {
    NSInvocationOperation *invocationOp =
        [[NSInvocationOperation alloc]initWithTarget:self
                                            selector:@selector(downloadImage) object:nil];
//    [invocationOp start]; //在当前线程中调用
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:invocationOp];
    
}

- (IBAction)useBlockOperation:(id)sender {
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        [self downloadImage];
    }];
//    [blockOp start];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:blockOp];
}

- (IBAction)useSubclassOperation:(id)sender {
    DownloadImageOperation *op = [[DownloadImageOperation alloc]init];
    op.downloadImageDelegate = self;
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:op];
}

- (void)refreshImageOnMain:(UIImage *)image
{
    [self refreshImage:image];
}

- (void)downloadImage
{
    NSLog(@"current thread:%@",[NSThread currentThread]);
    NSURL *url = [NSURL URLWithString:@"http://img.sc115.com/uploads/sc/jpgs/05/xpic6813_sc115.com.jpg"];
    UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
    [self performSelectorOnMainThread:@selector(refreshImage:)
                           withObject:image
                        waitUntilDone:YES];
}

- (void)refreshImage:(UIImage *)image
{
    if (!image) {
        NSLog(@"NO image!");
    }else{
        [self.imageView setImage:image];
    }
    [NSTimer scheduledTimerWithTimeInterval:2.0f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self.imageView setImage:nil];
    }];
}

@end



