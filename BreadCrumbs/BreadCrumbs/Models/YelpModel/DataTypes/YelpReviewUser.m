//
//  YelpReviewUser.m
//  iosChatClient
//
//  Created by Daniel F Wyatt on 11/3/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "YelpReviewUser.h"

@implementation YelpReviewUser

#pragma mark - JSONModel Methods

//This method can modify the map of JSON names -> Propoerty Names
+ (JSONKeyMapper*)keyMapper
{
    NSDictionary *map = @{ @"id" : @"userId",
                           @"img_url" : @"imgUrl"
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:map];
    //return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
