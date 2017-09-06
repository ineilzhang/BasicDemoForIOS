//
//  NZItem.h
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/9.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NZItem : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,assign) NSString *price;

@property (nonatomic,strong) NSString *serial;

@property (nonatomic,strong) NSDate *createDate;

@property (nonatomic,strong) NSString *itemKey;

- (instancetype)initWithName:(NSString *)name;

- (instancetype)initWithName:(NSString *)name
                       price:(NSString *)price
                      serial:(NSString *)serial;

@end
