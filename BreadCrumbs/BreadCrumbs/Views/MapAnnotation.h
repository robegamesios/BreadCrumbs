//
//  MapAnnotation.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 2/17/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "OCGrouping.h"

@interface MapAnnotation : NSObject <MKAnnotation, OCGrouping>

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *groupTag;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate;

@end
