//
//  NZItemCell.h
//  NZObjectList
//
//  Created by Neil Zhang on 2017/9/25.
//  Copyright © 2017年 Neil Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *serialLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic,copy) void (^actionBlock) (void);

@end
