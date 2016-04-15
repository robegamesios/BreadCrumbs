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
#import "LMGeocoder.h"

@interface SearchViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *nameSearchTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationSearchTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarButtonItem;


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
        self.locationSearchTextField.placeholder = [GlobalLocalizations localizedPlaceholderCurrentLocation];
    }

}

- (void)setupDataSource {
    self.tableView.dataSource = self.dataSource;
    self.dataSource.navigationController = self.navigationController;
    
    __weak typeof(self) weakSelf = self;
    
    self.dataSource.SearchResultBlock = ^(NSString *term, NSString *location) {
        weakSelf.SearchResultBlock(term, location, NO);
    };
    
    [self.tableView reloadData];
}


#pragma mark - Control Events

- (void)textFieldDidChange:(UITextField *)textfield {
    
    NSString *searchLocation;
    
    searchLocation = [NSString stringWithFormat:@"%@, %@", self.nameSearchTextField.text, self.locationSearchTextField.text];
    
    [self.dataSource.fetcher sourceTextHasChanged:searchLocation];
    
    self.searchBarButtonItem.enabled = ![self.nameSearchTextField.text isEqualToString: @""];
}


#pragma mark - IBActions

- (IBAction)searchBarButtonItemTapped:(UIBarButtonItem *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    if (self.SearchResultBlock) {
        
        if ([self.locationSearchTextField.text isEqualToString:@""]) {
            
            if ([[SingletonLocalService sharedManager] isLocationServicesAvailable]) {
                [[SingletonLocalService sharedManager] getUserLocationWithSuccessHandler:^(id responseObject) {
                    CLLocation *result = responseObject;
                    
                    [[LMGeocoder sharedInstance]reverseGeocodeCoordinate:result.coordinate service:kLMGeocoderAppleService completionHandler:^(NSArray *results, NSError *error) {
                        
                        if (results.count && !error) {
                            LMAddress *address = [results firstObject];
                            weakSelf.SearchResultBlock(weakSelf.nameSearchTextField.text,address.formattedAddress, YES);
                            
                        } else {
                            NSLog(@"SearchViewController searchButtonTapped, reverse geocoding error");
                        }
                    }];
                }];
            }

        } else {
            self.SearchResultBlock(weakSelf.nameSearchTextField.text,weakSelf.locationSearchTextField.text, NO);
            
        }
    }
}

- (IBAction)cancelBarButtonItemTapped:(UIBarButtonItem *)sender {
    if (self.CancelBlock) {
        self.CancelBlock();
    }
}


@end
