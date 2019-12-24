//
//  WodListPresenterImpl.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "WodListPresenterImpl.h"

@implementation WodListPresenterImpl

- (void)setView:(id<WodListViewProtocol>)view {
    _view = view;
    NSLog(@"View set on presenter");
}

@end
