//
//  WodListViewController.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "WodListViewController.h"

@interface WodListViewController ()

@property (strong, nonatomic) id<WodListPresenter> presenter;

@end


@implementation WodListViewController

- (instancetype)initWithPresenter:(id<WodListPresenter>)presenter {
    self = [super init];
    if (self) {
        _presenter = presenter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.presenter setView:self];
    self.view.backgroundColor = [UIColor purpleColor];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

#pragma mark - WodListView

- (void)presentWodList:(NSArray<WodListViewItem *> *)wodList {

}

@end
