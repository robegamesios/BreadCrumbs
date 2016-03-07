//
//  GlobalConstants.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/2/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "GlobalConstants.h"

#pragma mark - Yelp Credentials

NSString * const kAPIHost           = @"api.yelp.com";
NSString * const kSearchPath        = @"/v2/search/";
NSString * const kBusinessPath      = @"/v2/business/";
NSString * const kSearchLimit       = @"10";

const struct StoryboardName StoryboardName = {
    
    .main = @"Main",
    
};

const struct ScreenStoryboardId ScreenStoryboardId = {
    
     .businessesMapViewController = @"BusinessesMapViewControllerboardId",
    .businessesListTableViewController = @"BusinessesListTableViewControllerStoryboardId",
    .businessDetailsViewController = @"BusinessDetailsViewControlleStoryboardId",
    
};

@implementation GlobalConstants

+ (NSURL *)globalBaseUrl {
//    return [NSURL URLWithString:@"http://api.kivaws.org"];
    return [NSURL URLWithString:kAPIHost];

}

+ (NSString *)globalTestPath {
//    return @"v1/loans/search.json?status=fundraising";
    return @"https://api.yelp.com/v2/search";
}

@end