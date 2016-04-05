//
//  MapUtility.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/8/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "MapUtility.h"
@import AddressBookUI;

#define METERS_PER_MILE 1609.344

@implementation MapUtility

+ (void)centerMap:(MKMapView *)mapview atLocation:(CLLocationCoordinate2D)coordinate zoomLevel:(double)zoomLevel {
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, zoomLevel*METERS_PER_MILE, zoomLevel*METERS_PER_MILE);
    
    [mapview setRegion:viewRegion animated:YES];
}

+ (void)reverseGeocodeAddressWithCLLocation:(CLLocation *)location successHandler:(SuccessBlock)successHandler {

    __block NSString *addressString;
    
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:
     ^(NSArray* placemarks, NSError* error) {
         
         if ([placemarks count] > 0) {
             CLPlacemark *placeMark = [placemarks firstObject];
             
             NSArray *lines = placeMark.addressDictionary[@"FormattedAddressLines"];
             addressString = [lines componentsJoinedByString:@","];
             
             if (successHandler) {
                 successHandler(addressString);
             }
             
         }
     }];
}
@end
