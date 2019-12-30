//
//  WodItemCell.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/30/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WodListViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface WodItemCell : UITableViewCell

- (void)setWodItem:(WodListViewItem *)wodListItem;

@end

NS_ASSUME_NONNULL_END
