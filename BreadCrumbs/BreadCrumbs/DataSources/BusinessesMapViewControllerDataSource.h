//
//  BusinessesMapViewControllerDataSource.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/6/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import MapKit;

@interface BusinessesMapViewControllerDataSource : NSObject <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (copy, nonatomic) NSArray *businessesArray;
@property (strong, nonatomic) CLLocation *currentLocation;

- (id)initWithMapView:(MKMapView *)mapView;
- (void)setupViewAndUseCurrentLocation:(BOOL)useCurrentLocation;

@end
