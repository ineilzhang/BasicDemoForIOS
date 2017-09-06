//
//  NZItem.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/9.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZItem.h"
#import <UIKit/UIKit.h>

@interface NZItem ()


@end

@implementation NZItem

- (instancetype)initWithName:(NSString *)name
                       price:(NSString *)price
                      serial:(NSString *)serial
{
    if (self = [super init]) {
        self.name = [self randomName];
        self.price = [self randomPrice];
        self.serial = [self randomSerial];
        self.createDate = [NSDate date];
        NSUUID *uuid = [[NSUUID alloc]init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name
                        price:nil
                       serial:nil];
}

- (instancetype)init
{
    return [self initWithName:nil
                        price:nil
                       serial:nil];
}

- (UIColor *)randomColor
{
    CGFloat r = arc4random() % 1;
    CGFloat g = arc4random() % 1;
    CGFloat b = arc4random() % 1;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}


- (NSString *)randomPrice{
    return [NSString stringWithFormat:@"%u$",arc4random() % 100];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"object:%@ price:%@ serial:%@",self.name,self.price,self.serial];
}


- (NSString *)randomName{
    return [NSString stringWithFormat:@"00%c",('A' + arc4random() % 26)];
}

- (NSString *)randomSerial{
    return [NSString stringWithFormat:@"952%c",('0' + arc4random() % 10)];
}

@end
