//
//  GlobalConstants.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/2/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - Storyboard

extern const struct StoryboardName {
    
    __unsafe_unretained NSString *main;
    
} StoryboardName;

extern const struct ScreenStoryboardId {
    
    __unsafe_unretained NSString *businessesMapViewController;
    __unsafe_unretained NSString *businessesListTableViewController;
    __unsafe_unretained NSString *businessDetailsViewController;
    __unsafe_unretained NSString *searchViewController;
    
} ScreenStoryboardId;


#pragma mark - TypeDefs

typedef void(^VoidBlock)(void);
typedef void(^SuccessBlock)(id responseObject);
typedef void(^ErrorBlock)(NSString *errorString);


#pragma mark - Yelp Credentials

extern NSString * const kAPIHost;
extern NSString * const kSearchPath;
extern NSString * const kBusinessPath;
extern NSString * const kSearchLimit;


#pragma mark - GlobalStrings

extern NSString * const kMapMarkerRed;

