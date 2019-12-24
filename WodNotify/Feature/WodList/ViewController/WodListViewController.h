//
//  WodListViewController.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WodListContract.h"

NS_ASSUME_NONNULL_BEGIN

@interface WodListViewController : UITableViewController <WodListViewProtocol>

- (instancetype)initWithPresenter:(id<WodListPresenterProtocol>)presenter;

@end

NS_ASSUME_NONNULL_END
