//
//  NSURLRequest+OAuth.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/5/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "NSURLRequest+OAuth.h"
#import <TDOAuth/TDOAuth.h>

/**
 OAuth credential placeholders that must be filled by each user in regards to
 http://www.yelp.com/developers/getting_started/api_access
 */
#warning Fill in the API keys below with your developer v2 keys.
static NSString * const kConsumerKey       = @"QfVPObKvs1XTb3QS0eGtIA";
static NSString * const kConsumerSecret    = @"BdN0xIZ-4Ujc_8_dHYTudLZ1Up8";
static NSString * const kToken             = @"zarPBSFaYMz_Yiy5p69n5qSJ4S8CbJZE";
static NSString * const kTokenSecret       = @"gRcBPshzJk9MsbEaVugRgCIkp2g";

@implementation NSURLRequest (OAuth)

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path {
    return [self requestWithHost:host path:path params:nil];
}

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params {
    if ([kConsumerKey length] == 0 || [kConsumerSecret length] == 0 || [kToken length] == 0 || [kTokenSecret length] == 0) {
        NSLog(@"WARNING: Please enter your api v2 credentials before attempting any API request. You can do so in NSURLRequest+OAuth.m");
    }
    
    return [TDOAuth URLRequestForPath:path
                        GETParameters:params
                               scheme:@"https"
                                 host:host
                          consumerKey:kConsumerKey
                       consumerSecret:kConsumerSecret
                          accessToken:kToken
                          tokenSecret:kTokenSecret];
}

@end
