//
//  SingletonLocalService.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 4/2/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonLocalService : NSObject

+ (id)sharedManager;

- (BOOL)isLocationServicesAvailable;
- (void)getUserLocationWithSuccessHandler:(SuccessBlock)successHandler;

@end
