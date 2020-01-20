//
//  WodListContract.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WodListViewItem.h"

#ifndef WodListContract_h
#define WodListContract_h

#pragma mark - WodListView

@protocol WodListViewProtocol

- (void)presentWodList:(NSArray<WodListViewItem *> *)wodList;

@end


#pragma mark - WodListPresenter

@protocol WodListPresenterProtocol

- (void)setView:(id<WodListViewProtocol>)view;

- (void)loadData;

- (void)handleWodListViewItemSelection:(WodListViewItem *)item;

@end

#endif /* WodListContract_h */
