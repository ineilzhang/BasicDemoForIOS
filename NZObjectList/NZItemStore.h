//
//  NZItemStore.h
//  NZObjectList
//
//  Created by Neil Zhang on 2017/8/9.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZItem.h"

@interface NZItemStore : NSObject

@property (nonatomic,readonly) NSArray *items;

+ (instancetype)shareManage;

- (NZItem *)createItem;

- (void)deleteItem:(NZItem *)item;

- (NSArray *)allItems;

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;

@end
