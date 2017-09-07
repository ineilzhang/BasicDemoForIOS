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

#pragma mark - public method

+ (instancetype)shareManager
{
    static NZImageStore *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NZImageStore alloc]init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearCache:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    });
    return instance;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    if (!key) {
        NSLog(@"key can‘t be nil.");
        return;
    }
//    [self.privateDic setObject:image forKey:key];
    self.privateDic[key] = image;
    NSString *imagePath = [self imagePathForKey:key];
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
//    return [self.privateDic objectForKey:key];
    UIImage *resultImage = self.privateDic[key];
    if (!resultImage) {
        NSString *imagePath = [self imagePathForKey:key];
        resultImage = [UIImage imageWithContentsOfFile:imagePath];
        if (resultImage) {
            self.privateDic[key] = resultImage;
        }else{
            NSLog(@"error===can't find image file:%@",[self imagePathForKey:key]);
        }
    }
    return resultImage;
}

- (void)deleteImageForKey:(NSString *)key
{
    if(!key){
        return;
    }
    [self.privateDic removeObjectForKey:key];
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[docDirs firstObject] stringByAppendingPathComponent:key];
}

#pragma mark - property method

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

#pragma mark - private method

- (void)clearCache:(NSNotification *)notification
{
    [self.privateDic removeAllObjects];
}

@end
