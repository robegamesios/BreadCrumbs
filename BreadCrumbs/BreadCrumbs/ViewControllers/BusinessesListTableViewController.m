//
//  BusinessesListTableViewController.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/1/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "BusinessesListTableViewController.h"
#import "BusinessesListTableViewControllerDataSource.h"
#import "NetworkService.h"
#import "GlobalConstants.h"

@interface BusinessesListTableViewController ()

@property (strong, nonatomic) BusinessesListTableViewControllerDataSource *dataSource;
@end

@implementation BusinessesListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupDataSource];
}


#pragma mark - Accessors

- (BusinessesListTableViewControllerDataSource *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [[BusinessesListTableViewControllerDataSource alloc]initWithTableView:self.tableView];
    }
    return _dataSource;
}

- (void)setupDataSource {
    self.tableView.dataSource = self.dataSource;
    self.dataSource.navigationController = self.navigationController;

    [self.tableView reloadData];
}

- (void)updateResults {
    self.dataSource.businessesArray = self.resultArray;
    [self.tableView reloadData];
}

@end
