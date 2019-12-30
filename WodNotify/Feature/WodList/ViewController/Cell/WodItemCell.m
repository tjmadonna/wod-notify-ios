//
//  WodItemCell.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/30/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "WodItemCell.h"

@interface WodItemCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UILabel *dayOfMonthLabel;

@property (weak, nonatomic) IBOutlet UILabel *dayOfWeekLabel;

@end

@implementation WodItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWodItem:(WodListViewItem *)wodListItem {
    self.titleLabel.text = wodListItem.title;
    self.authorLabel.text = wodListItem.author;
}

@end
