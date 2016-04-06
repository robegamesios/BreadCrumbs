//
//  MapUtility.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/8/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface MapUtility : NSObject

+ (void)centerMap:(MKMapView *)mapview atLocation:(CLLocationCoordinate2D)coordinate zoomLevel:(double)zoomLevel;

@end
