//
//  BusinessesListTableViewControllerDataSource.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/6/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface BusinessesListTableViewControllerDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSArray *businessesArray;

- (id)initWithTableView:(UITableView *)tableView;

@end
