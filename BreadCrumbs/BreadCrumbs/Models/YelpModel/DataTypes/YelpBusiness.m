//
//  YelpLocation.m
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/28/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "YelpBusiness.h"
#import <objc/runtime.h>

@implementation YelpBusiness

#pragma mark - JSONModel Methods

//This method can modify the map of JSON names -> Propoerty Names
+ (JSONKeyMapper*)keyMapper
{
    NSDictionary *map = @{ @"id" : @"yelpId",
                           @"distance" : @"distanceInMeters",
                           @"is_claimed" : @"isClaimed",
                           @"is_closed" : @"isClosed",
                           @"image_url" : @"imageUrl",
                           @"mobile_url" : @"mobileUrl",
                           @"display_phone" : @"displayPhone",
                           @"gift_certificates" : @"giftCertificates",
                           @"review_count" : @"reviewCount",
                           @"rating_img_url" : @"ratingImgUrl",
                           @"rating_img_url_small" : @"ratingImgUrlSmall",
                           @"rating_img_url_large" : @"ratingImgUrlLarge",
                           @"snippet_text" : @"snippetText",
                           @"snippet_image_url" : @"snippetImgUrl",
                           @"menu_provider" : @"menuProvider",
                           @"menu_date_updated": @"menuDateUpdated"
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:map];
    //return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

#pragma mark - Custom Property Transformers

- (void)setCategoriesWithNSArray:(NSArray*)array{
    
    NSMutableArray *newCategories = [NSMutableArray new];
    
    //NSLog(array.description);
    for (NSArray *items in array){
        
        //cram the data in to the right fields
        YelpCategory *category = [YelpCategory new];
        category.name = items[0];//[self cleanString:items[0]];
        category.alias = items[1];//[self cleanString:items[1]];
        
        [newCategories addObject:category];

    }
    
    self.categories = [newCategories copy];
}

- (void)toString{
    
    NSLog(@"----------------------------------------------- Properties for object %@", self);
    
    @autoreleasepool {
        unsigned int numberOfProperties = 0;
        objc_property_t *propertyArray = class_copyPropertyList([self class], &numberOfProperties);
        for (NSUInteger i = 0; i < numberOfProperties; i++) {
            objc_property_t property = propertyArray[i];
            NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
            NSLog(@"Property %@ Value: %@", name, [self valueForKey:name]);
        }
        free(propertyArray);
    }
    NSLog(@"-----------------------------------------------");
}

#pragma mark - Internal Functions

- (NSString*)cleanString:(NSString*)string{
    
    //creates a mutable string with no whitespace from the original string
    NSMutableString *mutString = [[NSMutableString alloc] initWithString:
                                  [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    //removes any quotes
    [mutString replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutString length])];
    
    //removes any commas
    [mutString replaceOccurrencesOfString:@"," withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutString length])];

    return mutString;
    
}


@end
