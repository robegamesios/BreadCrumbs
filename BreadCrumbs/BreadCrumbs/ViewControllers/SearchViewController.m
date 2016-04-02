//
//  SearchViewController.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/30/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchViewControllerDataSource.h"
@import GoogleMaps;


@interface SearchViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *nameSearchTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationSearchTextField;

@property (strong, nonatomic) SearchViewControllerDataSource *dataSource;

@end


@implementation SearchViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupDataSource];
}


#pragma mark - Accessors

- (SearchViewControllerDataSource *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [[SearchViewControllerDataSource alloc]initWithTableView:self.tableView];
    }
    return _dataSource;
}

- (void)setupView {
    self.nameSearchTextField.delegate = self;
    self.locationSearchTextField.delegate = self;
    
    [self.nameSearchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.locationSearchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    if ([[SingletonLocalService sharedManager] isLocationServicesAvailable]) {
        self.locationSearchTextField.placeholder = @"Current Location";
    }

}

- (void)setupDataSource {
    self.tableView.dataSource = self.dataSource;
    self.dataSource.navigationController = self.navigationController;
    
    [self.tableView reloadData];
}


#pragma mark - Control Events

- (void)textFieldDidChange:(UITextField *)textfield {
    
    NSString *searchLocation;
    
    if (self.locationSearchTextField.text != nil) {
        searchLocation = [NSString stringWithFormat:@"%@, %@", self.nameSearchTextField.text, self.locationSearchTextField.text];

    } else {
        searchLocation = [NSString stringWithFormat:@"%@", self.nameSearchTextField.text];
    }
    
    [self.dataSource.fetcher sourceTextHasChanged:searchLocation];
}

@end
