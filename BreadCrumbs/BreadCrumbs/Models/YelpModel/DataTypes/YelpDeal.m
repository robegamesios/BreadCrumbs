//
//  YelpDeal.m
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "YelpDeal.h"

@implementation YelpDeal

#pragma mark - JSONModel Methods

//This method can modify the map of JSON names -> Propoerty Names
+ (JSONKeyMapper*)keyMapper
{
    NSDictionary *map = @{ @"id" : @"dealId",
                           @"image_url" : @"imageUrl",
                           @"currency_code" : @"currencyCode",
                           @"time_start" : @"timeStart",
                           @"time_end" : @"timeEnd",
                           @"is_popular" : @"isPopular",
                           @"what_you_get" : @"whatYouGet",
                           @"important_restrictions" : @"importantRestrictions",
                           @"additional_restrictions" : @"additionalRestrictions",
                           @"purchase_url" : @"purchaseUrl",
                           @"formatted_price" : @"formattedPrice",
                           @"original_price" : @"originalPrice",
                           @"formatted_original_price" : @"formattedOriginalPrice",
                           @"is_quantity_limited" : @"isQuantityLimited",
                           @"remaining_count" : @"remainingCount"
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:map];
    //return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

#pragma mark - Custom Property Transformers

- (void)setOptionsWithNSArray:(NSArray*)array{
    
    NSDictionary *dealDict = array[0];
    
    self.options = [[YelpDealOptions alloc] initWithDictionary:dealDict error:nil];
    
}


@end
