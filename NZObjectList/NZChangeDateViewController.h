//
//  NZChangeDateViewController.h
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/10.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^blk) (NSDate *);

@interface NZChangeDateViewController : UIViewController

@property (nonatomic,strong) NSDate *pickDate;

@property (nonatomic,copy) blk pickDateBlk;

@end
