//
//  MapAnnotation.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 2/17/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
{
    self = [super init];
    if (self) {
        _coordinate = aCoordinate;
    }
    return self;
}

#pragma mark equality

- (BOOL)isEqual:(MapAnnotation*)annotation;
{
    if (![annotation isKindOfClass:[MapAnnotation class]]) {
        return NO;
    }
    
    return (self.coordinate.latitude == annotation.coordinate.latitude &&
            self.coordinate.longitude == annotation.coordinate.longitude &&
            [self.name isEqualToString:annotation.title] &&
            [self.location isEqualToString:annotation.subtitle] &&
            [self.groupTag isEqualToString:annotation.groupTag]);   
}

@end
