//
//  YelpLocation.m
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "YelpLocation.h"

@implementation YelpLocation

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end

@implementation YelpLocationCoordinate

+ (JSONKeyMapper *)keyMapper {
    
    NSDictionary *map = @{@"latitude" : @"coordLatitude",
                          @"longitude" : @"coordLongitude"};
    
    return [[JSONKeyMapper alloc] initWithDictionary:map];
}

@end