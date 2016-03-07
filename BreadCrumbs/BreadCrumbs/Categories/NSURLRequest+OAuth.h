//
//  NSURLRequest+OAuth.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/5/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (OAuth)

/**
 @param host The domain host
 @param path The path on the domain host
 @return Builds a NSURLRequest with all the OAuth headers field set with the host and path given to it.
 */
+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path;

/**
 @param host The domain host
 @param path The path on the domain host
 @param params The query parameters
 @return Builds a NSURLRequest with all the OAuth headers field set with the host, path, and query parameters given to it.
 */
+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params;

@end
