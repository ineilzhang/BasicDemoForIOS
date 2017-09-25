//
//  NZItemCell.m
//  NZObjectList
//
//  Created by Neil Zhang on 2017/9/25.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import "NZItemCell.h"

@implementation NZItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
