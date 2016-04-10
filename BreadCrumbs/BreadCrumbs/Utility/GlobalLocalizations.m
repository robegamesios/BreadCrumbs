//
//  GlobalLocalizations.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 4/1/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "GlobalLocalizations.h"

static NSString *const GlobalLocalizedString = @"global localization string";

static NSString *const GlobalLocalizedMessage = @"global localization message";
static NSString *const GlobalLocalizedErrorMessage = @"global localization error message";


@implementation GlobalLocalizations

//Strings
+ (NSString *)localizedStringList {
    return NSLocalizedString(@"List", GlobalLocalizedString);
}

+ (NSString *)localizedStringMap {
    return NSLocalizedString(@"Map", GlobalLocalizedString);
}


//Messages
+ (NSString *)localizedMessageNoResultsFound {
    return NSLocalizedString(@"No results found", GlobalLocalizedMessage);
}

+ (NSString *)localizedPlaceholderCurrentLocation {
    return  NSLocalizedString(@"Current location or Enter location", GlobalLocalizedMessage);
}


//Error Messages
+ (NSString *)localizedFaildToGetUserLocation {
    return NSLocalizedString(@"Sorry but we could not determine your location", GlobalLocalizedErrorMessage);
}
@end
