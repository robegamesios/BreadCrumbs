//
//  GlobalLocalizations.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 4/1/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "GlobalLocalizations.h"

static NSString *const GlobalLocalizedMessage = @"global localization message";
static NSString *const GlobalLocalizedErrorMessage = @"global localization error message";

@implementation GlobalLocalizations

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
