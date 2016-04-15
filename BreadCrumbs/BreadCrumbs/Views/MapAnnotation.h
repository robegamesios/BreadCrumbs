//
//  MapAnnotation.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 2/17/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *ratingImageUrl;
@property (copy, nonatomic) NSString *reviews;
@property (copy, nonatomic) NSString *category;
@property (copy, nonatomic) NSString *availabilityStatus;
@property (copy, nonatomic) NSString *distance;
@property (copy, nonatomic) UIImage *image;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate;

@end
