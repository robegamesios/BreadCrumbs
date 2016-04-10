//
//  GlobalLocalizations.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 4/1/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalLocalizations : NSObject

//Strings
+ (NSString *)localizedStringList;
+ (NSString *)localizedStringMap;


//Messages
+ (NSString *)localizedMessageNoResultsFound;
+ (NSString *)localizedPlaceholderCurrentLocation;


//Error Messages
+ (NSString *)localizedFaildToGetUserLocation;

@end
