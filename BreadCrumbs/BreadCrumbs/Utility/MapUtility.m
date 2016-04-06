//
//  MapUtility.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/8/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "MapUtility.h"

#define METERS_PER_MILE 1609.344

@implementation MapUtility

+ (void)centerMap:(MKMapView *)mapview atLocation:(CLLocationCoordinate2D)coordinate zoomLevel:(double)zoomLevel {
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, zoomLevel*METERS_PER_MILE, zoomLevel*METERS_PER_MILE);
    
    [mapview setRegion:viewRegion animated:YES];
}


@end
