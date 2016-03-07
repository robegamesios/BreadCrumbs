//
//  YelpDeal-Options.m
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/31/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "YelpDealOptions.h"

@implementation YelpDealOptions

-(NSString*)description{
        
    return self.title;
}


#pragma mark - JSONModel Methods

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
