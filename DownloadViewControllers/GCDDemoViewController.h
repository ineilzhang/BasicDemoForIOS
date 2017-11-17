//
//  GCDDemoViewController.h
//  MultithreadingDemo
//
//  Created by Neil Zhang on 2017/11/17.
//  Copyright © 2017年 inspur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCDDemoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
- (IBAction)dispatchAsyncDemo:(id)sender;
- (IBAction)dispatchSyncDemo:(id)sender;
- (IBAction)dispatchAfterDemo:(id)sender;
- (IBAction)dispatchGroupDemo:(id)sender;
- (IBAction)dispatchBarrierAsync:(id)sender;
- (IBAction)dispatchBarrierAsyncDemo:(id)sender;
- (IBAction)dispatchOnceDemo:(id)sender;
- (IBAction)dispatchSemaphoreDemo:(id)sender;

@end
