//
//  BusinessesMapViewController.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 2/17/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

@import UIKit;
@import MapKit;

@interface BusinessesMapViewController : UIViewController

@property (copy, nonatomic) NSArray *resultArray;

- (void)updateResultsFromCurrentLocation:(BOOL)fromCurrentLocation;

@end
