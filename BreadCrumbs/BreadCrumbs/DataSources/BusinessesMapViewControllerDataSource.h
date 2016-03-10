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

@class OCMapView;

@interface BusinessesMapViewControllerDataSource : NSObject <MKMapViewDelegate>

@property (strong, nonatomic) OCMapView *mapView;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSArray *businessesArray;

- (id)initWithMapView:(OCMapView *)mapView;
- (void)setupView;

@end
