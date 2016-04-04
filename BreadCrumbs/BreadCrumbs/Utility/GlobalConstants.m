//
//  GlobalConstants.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/2/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "GlobalConstants.h"


#pragma mark - Storyboard

const struct StoryboardName StoryboardName = {
    
    .main = @"Main",
    
};

const struct ScreenStoryboardId ScreenStoryboardId = {
    
     .businessesMapViewController = @"BusinessesMapViewControllerboardId",
    .businessesListTableViewController = @"BusinessesListTableViewControllerStoryboardId",
    .businessDetailsViewController = @"BusinessDetailsViewControlleStoryboardId",
    .searchViewController = @"SearchViewControllerStoryboardId",
    
};


#pragma mark - Yelp Credentials

NSString * const kAPIHost           = @"api.yelp.com";
NSString * const kSearchPath        = @"/v2/search/";
NSString * const kBusinessPath      = @"/v2/business/";
NSString * const kSearchLimit       = @"10";
NSString * const kBusinessKey       = @"businesses";

#pragma mark - GlobalStrings

NSString * const kMapMarkerRed = @"marker-red";

