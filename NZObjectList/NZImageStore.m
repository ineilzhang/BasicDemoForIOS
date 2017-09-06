//
//  NZImageStore.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/10.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZImageStore.h"

@interface NZImageStore ()

@property (nonatomic,strong) NSMutableDictionary *privateDic;

@end


@implementation NZImageStore

+ (instancetype)shareManager
{
    static NZImageStore *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NZImageStore alloc]init];
    });
    return instance;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.privateDic setObject:image forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key
{
    return [self.privateDic objectForKey:key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if(!key){
        return;
    }
    [self.privateDic removeObjectForKey:key];
}

- (NSDictionary *)dictionary
{
    return [self.privateDic copy];
}

- (NSMutableDictionary *)privateDic
{
    if (!_privateDic) {
        _privateDic = [[NSMutableDictionary alloc]init];
    }
    return _privateDic;
}

@end
