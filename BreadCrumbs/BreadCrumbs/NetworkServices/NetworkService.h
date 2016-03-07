//
//  NetworkService.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/5/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

+ (id)sharedNetworkService;

- (void)queryStoreWithType:(NSString *)term location:(NSString *)location successHandler:(SuccessBlock)successHandler errorHandler:(ErrorBlock)errorHandler;

//- (void)NetworkGetStoreswithBaseUrl:(NSURL *)baseUrl path:(NSString *)path parameters:(id)params successHandler:(SuccessBlock) successHandler errorHandler:(ErrorBlock) errorHandler;

@end
