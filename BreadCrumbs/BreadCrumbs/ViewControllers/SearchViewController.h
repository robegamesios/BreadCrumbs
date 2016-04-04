//
//  SearchViewController.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/30/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (copy, nonatomic) void(^SearchResultBlock)(NSString *term, NSString *location);

@end
