//
//  NZImageStore.h
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/10.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NZImageStore : NSObject

@property (nonatomic,strong) NSDictionary *dictionary;

+ (instancetype)shareManager;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;

- (UIImage *)imageForKey:(NSString *)key;

- (void)deleteImageForKey:(NSString *)key;


@end
