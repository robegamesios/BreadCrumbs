//
//  BusinessDetailsViewController.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/4/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "BusinessDetailsViewController.h"
#import "NetworkService.h"
#import "GlobalConstants.h"

@interface BusinessDetailsViewController ()

@end

@implementation BusinessDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testJSON];
}

- (void)testJSON {
    
    [[NetworkService sharedNetworkService] queryStoreWithType:@"food" location:@"daly city" successHandler:^(id responseObject) {

        NSArray *array = [NSArray arrayWithArray:responseObject];
        
        NSLog(@"ARRAY = %i",array.count);
        NSLog(@"ARRAY = %@",array);
        
    } errorHandler:^(NSString *errorString) {
        NSLog(@"JSON Network error = %@", errorString);
    }];
}

@end
