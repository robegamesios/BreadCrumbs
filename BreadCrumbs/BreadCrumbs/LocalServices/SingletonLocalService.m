//
//  SingletonLocalService.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 4/2/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "SingletonLocalService.h"
#import <INTULocationManager/INTULocationManager.h>

@implementation SingletonLocalService

- (id)init {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

+ (id)sharedManager {
    static SingletonLocalService *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


#pragma mark - Location Services

- (BOOL)isLocationServicesAvailable {
    return [CLLocationManager locationServicesEnabled];
}

- (void)getUserLocationWithSuccessHandler:(SuccessBlock)successHandler {

    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.f block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        
        if (status == INTULocationStatusSuccess) {
            
            if (successHandler) {
                successHandler(currentLocation);
            }
            
        } else if (status == INTULocationStatusTimedOut) {
            
        } else {
            
        }
    }];
}

@end
