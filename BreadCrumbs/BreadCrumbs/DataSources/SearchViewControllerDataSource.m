//
//  SearchViewControllerDataSource.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/31/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "SearchViewControllerDataSource.h"


static NSString *const SearchListCellIdentifier = @"SearchListCellIdentifier";
static NSInteger const DefaultRowHeight = 55;


@interface SearchViewControllerDataSource ()

@property (strong, nonatomic) NSArray *resultsArray;

@end


@implementation SearchViewControllerDataSource

- (id)initWithTableView:(UITableView *)tableView {
    self = [super init];
    
    if (self) {
        self.tableView = tableView;
        self.tableView.delegate = self;
        [self setupGoogleMaps];

    }
    return self;
}


#pragma mark - setup

- (void)setupGoogleMaps {
    
    __weak typeof(self) weakSelf = self;
    
    // Set up the autocomplete filter.
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterEstablishment;
    
    if ([[SingletonLocalService sharedManager] isLocationServicesAvailable]) {
        
        [[SingletonLocalService sharedManager] getUserLocationWithSuccessHandler:^(id responseObject) {
            
            CLLocation *result = responseObject;
            
            GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:result.coordinate coordinate:result.coordinate];
            
            weakSelf.fetcher = [[GMSAutocompleteFetcher alloc] initWithBounds:bounds
                                                                   filter:filter];
            weakSelf.fetcher.delegate = weakSelf;

        }];
        
    } else {
        // Create the fetcher.
        self.fetcher = [[GMSAutocompleteFetcher alloc] initWithBounds:nil
                                                               filter:filter];
        self.fetcher.delegate = self;
    }
}


#pragma mark - GMSAutocompleteFetcherDelegate

- (void)didAutocompleteWithPredictions:(NSArray *)predictions {
    self.resultsArray = nil;
    
    NSMutableString *resultsStr = [NSMutableString string];
    for (GMSAutocompletePrediction *prediction in predictions) {
        [resultsStr appendFormat:@"%@:%@;", [prediction.attributedPrimaryText string], [prediction. attributedSecondaryText string]];
    }

    self.resultsArray = [resultsStr componentsSeparatedByString:@";"];
    
    [self.tableView reloadData];
}

- (void)didFailAutocompleteWithError:(NSError *)error {
    [self showMessage:error.localizedDescription];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.resultsArray.count) {
        return self.resultsArray.count;
    }
    
    [self showMessage:[GlobalLocalizations localizedMessageNoResultsFound]];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchListCellIdentifier forIndexPath:indexPath];
    
    //RE: TODO: add cell info here
    NSString *currentResult = [self.resultsArray objectAtIndex:indexPath.row];
    NSArray *currentResultArray = [currentResult componentsSeparatedByString:@":"];
    
    cell.textLabel.text = currentResultArray.firstObject;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = currentResultArray.lastObject;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return DefaultRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //RE: TODO:
    NSLog(@"search cell tapped");
}


#pragma mark - methods

- (void)showMessage: (NSString *)message {
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                                      self.tableView.bounds.size.width,
                                                                      self.tableView.bounds.size.height)];
    messageLabel.text = message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [messageLabel sizeToFit];
    
    self.tableView.backgroundView = messageLabel;
}

@end
