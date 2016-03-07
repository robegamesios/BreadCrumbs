//
//  YelpGiftCertificate.m
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "YelpGiftCertificate.h"

@implementation YelpGiftCertificate

#pragma mark - JSONModel Methods

//This method can modify the map of JSON names -> Propoerty Names
+ (JSONKeyMapper*)keyMapper
{
    NSDictionary *map = @{ @"id" : @"certificateId",
                           @"image_url" : @"imageUrl",
                           @"currency_code" : @"currencyCode",
                           @"unused_balances" : @"unusedBalances"
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:map];
    //return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}



@end
