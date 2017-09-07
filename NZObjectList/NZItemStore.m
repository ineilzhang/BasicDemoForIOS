//
//  NZItemStore.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/9.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZItemStore.h"
#import "NZImageStore.h"

@interface NZItemStore ()

@property (nonatomic,strong) NSMutableArray *privateItems;

@end

@implementation NZItemStore

#pragma mark - overrice super method

- (instancetype)init{
    if (self = [super init]) {
//        self.privateItems = [[NSMutableArray alloc]init];
        self.privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:[self itemArchivePath]];
        if (!self.privateItems) {
            self.privateItems = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

#pragma mark - property method

- (NSArray *)items{
    return [self.privateItems copy];
}

#pragma mark - public class method

+ (instancetype)shareManage{
    static NZItemStore *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NZItemStore alloc]init];
    });
    return instance;
}

#pragma mark - public method

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    NZItem *fromItem = self.privateItems[fromIndex];
    [self.privateItems removeObject:fromItem];
    [self.privateItems insertObject:fromItem atIndex:toIndex];
}

- (NZItem *)createItem{
    NZItem *item = [[NZItem alloc]init];
    [self.privateItems addObject:item];
    return item;
}

- (void)deleteItem:(NZItem *)item{
    [self.privateItems removeObjectIdenticalTo:item];
    if (item.itemKey) {
       [[NZImageStore shareManager] deleteImageForKey:item.itemKey];
    }
}

- (NSArray *)allItems{
    return self.items;
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

#pragma mark - private method

- (NSString *)itemArchivePath
{
    NSArray *docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"document dir:%@",docDirs);
    NSString *docDir = [docDirs firstObject];
    return [docDir stringByAppendingPathComponent:@"items.archive"];
}

@end
