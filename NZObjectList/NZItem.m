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

#pragma mark - override super method

- (instancetype)initWithName:(NSString *)name
                       price:(NSString *)price
                      serial:(NSString *)serial
{
    if (self = [super init]) {
//        self.name = [self randomName];
//        self.price = [self randomPrice];
//        self.serial = [self randomSerial];
//        self.createDate = [NSDate date];
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

#pragma mark - nscoding delegete method

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.serial = [aDecoder decodeObjectForKey:@"serial"];
        self.createDate = [aDecoder decodeObjectForKey:@"createDate"];
        self.itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        self.thumbnail = [aDecoder decodeObjectForKey:@"thumbnail"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.serial forKey:@"serial"];
    [aCoder encodeObject:self.createDate forKey:@"createDate"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeObject:self.thumbnail forKey:@"thumbnail"];
}


#pragma mark - private method

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
    return [NSString stringWithFormat:@"name:%@ price:%@ serial:%@",self.name,self.price,self.serial];
}


- (NSString *)randomName{
    return [NSString stringWithFormat:@"00%c",('A' + arc4random() % 26)];
}

- (NSString *)randomSerial{
    return [NSString stringWithFormat:@"952%c",('0' + arc4random() % 10)];
}

- (void)setThumbnailFromImage:(UIImage *)image
{
    CGSize originImageSize = image.size;
    // 缩略图的大小
    CGRect thumbnailRect = CGRectMake(0, 0, 40, 40);
    // 确定缩放倍数
    float ratio = MAX(thumbnailRect.size.width / originImageSize.width, thumbnailRect.size.height / originImageSize.height);
    // 创建透明的位图上下文
    UIGraphicsBeginImageContextWithOptions(thumbnailRect.size, NO, 0.0);
    // 创建圆角矩形 UIBezierPath 对象
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:thumbnailRect cornerRadius:5.0];
    // 根据 UIBezierPath 对象裁剪图形上下文
    [path addClip];
    // 在缩略图范围内绘制
    [image drawInRect:thumbnailRect];
    UIImage *thubmnailImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = thubmnailImage;
    UIGraphicsEndImageContext();
    
}
@end
