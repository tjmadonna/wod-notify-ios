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

@property (strong, nonatomic) UIRefreshControl * pullToRefreshControl;

@end


@implementation WodListViewController

- (instancetype)initWithPresenter:(id<WodListPresenterProtocol>)presenter {
    self = [super init];
    if (self) {
        _presenter = presenter;
        _pullToRefreshControl = [[UIRefreshControl alloc] init];
        _pullToRefreshControl.tintColor = [UIColor colorNamed:@"MainColor"];
        _pullToRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Fetching Wods ..."];
        [_pullToRefreshControl addTarget:self
                                  action:@selector(loadData)
                        forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Wod Notify";
    [self setupTableView];
    [self.presenter setView:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setupTableView {
    self.tableView.rowHeight = 125;
    self.tableView.refreshControl = self.pullToRefreshControl;

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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WodListViewItem *item = self.wodItems[indexPath.item];
    [self.presenter handleWodListViewItemSelection:item];
}

#pragma mark - WodListView

- (void)hideRefreshControl {
    if ([self.pullToRefreshControl isRefreshing]) {
        // Delay execution of my block for 1 second. This prevents the tableview and indicator from overlapping
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.pullToRefreshControl endRefreshing];
        });
    }
}

- (void)presentWodList:(NSArray<WodListViewItem *> *)wodList {
    self.wodItems = wodList;
    NSLog(@"Presenting %lu items", wodList.count);
    [self.tableView reloadData];
}

#pragma mark - Helper functions

- (void)loadData {
    [self.presenter loadData];
}

@end
