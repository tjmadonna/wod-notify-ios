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

@protocol WodListView

- (void)presentWodList:(NSArray<WodListViewItem *> *)wodList;

@end


#pragma mark - WodListPresenter

@protocol WodListPresenter

- (void)setView:(id<WodListView>)view;

@end

#endif /* WodListContract_h */
