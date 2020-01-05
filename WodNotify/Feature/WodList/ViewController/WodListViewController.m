//
//  WodListViewController.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "WodListViewController.h"
#import "WodItemCell.h"

@interface WodListViewController ()

@property (strong, nonatomic) id<WodListPresenterProtocol> presenter;

@property (strong, nonatomic) NSArray<WodListViewItem *> * wodItems;

@end


@implementation WodListViewController

- (instancetype)initWithPresenter:(id<WodListPresenterProtocol>)presenter {
    self = [super init];
    if (self) {
        _presenter = presenter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Wod Notify";
    [self setupTableView];
    [self.presenter setView:self];
}

- (void)setupTableView {
    self.tableView.rowHeight = 125;

    UINib *nib = [UINib nibWithNibName:kWodItemCellNibName bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:kWodItemCellCellId];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wodItems ? self.wodItems.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WodItemCell *cell = [tableView dequeueReusableCellWithIdentifier:kWodItemCellCellId forIndexPath:indexPath];
    WodListViewItem *wodItem = self.wodItems[indexPath.item];
    [cell setWodItem:wodItem];
    return cell;
}

#pragma mark - WodListView

- (void)presentWodList:(NSArray<WodListViewItem *> *)wodList {
    self.wodItems = wodList;
    NSLog(@"Presenting %lu items", wodList.count);
    [self.tableView reloadData];
}

@end
