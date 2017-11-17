//
//  NSThreadDemoViewController.h
//  MultithreadingDemo
//
//  Created by Neil Zhang on 2017/11/17.
//  Copyright © 2017年 inspur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSThreadDemoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)dynamicCreateThread:(id)sender;

- (IBAction)staticCreateThread:(id)sender;

- (IBAction)implicitCreateThread:(id)sender;

@end
