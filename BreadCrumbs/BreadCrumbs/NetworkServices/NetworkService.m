//
//  NetworkService.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/5/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "NetworkService.h"
#import "AFURlRequestSerialization.h"
#import "AFHTTPSessionManager.h"
#import "GlobalConstants.h"
#import "NSURLRequest+OAuth.h"
#import "YelpBusiness.h"

@implementation NetworkService


#pragma mark - Singleton

+ (id)sharedNetworkService {
    static NetworkService *sharedNetworkService = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedNetworkService = [[self alloc] init];
    });
    
    return sharedNetworkService;
}

#pragma mark - Query

- (void)queryStoreWithType:(NSString *)term location:(NSString *)location successHandler:(SuccessBlock)successHandler errorHandler:(ErrorBlock)errorHandler {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [self searchRequestWithTerm:term location:location];
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            if (errorHandler) {
                errorHandler(error.localizedDescription);
            }
        } else {
            
            NSMutableArray *parsedBusinessArray = [self getYelpBusinessesFromQuery:responseObject];
            
            if (successHandler) {
                successHandler(parsedBusinessArray);
            }
        }
    }] resume];

}

//create objects from the response and check to see if it worked
- (NSMutableArray *) getYelpBusinessesFromQuery: (id) response {
    
    NSMutableArray *yelpLocations = [NSMutableArray new];
    
    if ([response  isKindOfClass: [NSDictionary class]]) {
        
        NSMutableArray *yelpBusinesses = [[NSMutableArray alloc] initWithArray:[response objectForKey:@"businesses"]];
        
        for (NSDictionary *item in yelpBusinesses) {
            
            YelpBusiness *newLocation= [[YelpBusiness alloc] initWithDictionary:item error:nil];
            
            [yelpLocations addObject:newLocation];
            
        }
        
        return yelpLocations;
        
    } else {
        return nil;
    };
}



//- (void)NetworkGetStoreswithBaseUrl:(NSURL *)baseUrl path:(NSString *)path parameters:(id)params successHandler:(SuccessBlock) successHandler errorHandler:(ErrorBlock) errorHandler {
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    //RE: DO this if you are changing the content type from json to text/html
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        
//    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        // Success
//        if (successHandler) {
//            successHandler(responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        // Failure
//        if (errorHandler) {
//            errorHandler(error.localizedDescription);
//        }
//    }];
//    
//}


//- (void)queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
//    
//    NSLog(@"Querying the Search API with term \'%@\' and location \'%@'", term, location);
//    
//    //Make a first request to get the search results with the passed term and location
//    NSURLRequest *searchRequest = [self _searchRequestWithTerm:term location:location];
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        
//        if (!error && httpResponse.statusCode == 200) {
//            
//            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSArray *businessArray = searchResponseJSON[@"businesses"];
//            
//            if ([businessArray count] > 0) {
//                NSDictionary *firstBusiness = [businessArray firstObject];
//                NSString *firstBusinessID = firstBusiness[@"id"];
//                NSLog(@"%lu businesses found, querying business info for the top result: %@", (unsigned long)[businessArray count], firstBusinessID);
//                
//                [self queryBusinessInfoForBusinessId:firstBusinessID completionHandler:completionHandler];
//            } else {
//                completionHandler(nil, error); // No business was found
//            }
//        } else {
//            completionHandler(nil, error); // An error happened or the HTTP response is not a 200 OK
//        }
//    }] resume];
//}

- (void)queryBusinessInfoForBusinessId:(NSString *)businessID completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:businessID];
    [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            completionHandler(businessResponseJSON, error);
        } else {
            completionHandler(nil, error);
        }
    }] resume];
    
}


#pragma mark - API Request Builders

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param location The location request, e.g: San Francisco, CA
 
 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)searchRequestWithTerm:(NSString *)term location:(NSString *)location {
    NSDictionary *params = @{
                             @"term": term,
                             @"location": location,
                             @"limit": kSearchLimit
                             };
    
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}

/**
 Builds a request to hit the business endpoint with the given business ID.
 
 @param businessID The id of the business for which we request informations
 
 @return The NSURLRequest needed to query the business info
 */
- (NSURLRequest *)_businessInfoRequestForID:(NSString *)businessID {
    
    NSString *businessPath = [NSString stringWithFormat:@"%@%@", kBusinessPath, businessID];
    return [NSURLRequest requestWithHost:kAPIHost path:businessPath];
}


@end
