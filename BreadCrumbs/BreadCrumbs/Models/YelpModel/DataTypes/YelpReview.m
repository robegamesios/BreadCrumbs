//
//  YelpReview.m
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "YelpReview.h"

@implementation YelpReview

#pragma mark - JSONModel Methods

//This method can modify the map of JSON names -> Propoerty Names
+ (JSONKeyMapper*)keyMapper
{
    NSDictionary *map = @{ @"id" : @"reviewId",
                           @"rating_img_url" : @"ratingImgUrl",
                           @"rating_img_small_url" : @"ratingImgSmallUrl",
                           @"rating_img_large_url" : @"ratingImgLargeUrl",
                           @"time_created" : @"timeCreated",
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:map];
    //return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
