//
//  SearchViewControllerDataSource.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/31/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleMaps;

@interface SearchViewControllerDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, GMSAutocompleteFetcherDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) GMSAutocompleteFetcher *fetcher;

@property (copy, nonatomic) void(^SearchResultBlock)(NSString *term, NSString *location);

- (id)initWithTableView:(UITableView *)tableView;

@end
