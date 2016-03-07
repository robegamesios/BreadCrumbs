//
//  YelpGiftCertificateOptions.m
//  iosChatClient
//
//  Created by Daniel F Wyatt on 11/3/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "YelpGiftCertificateOptions.h"

@implementation YelpGiftCertificateOptions

-(NSString*)description{
    
    
    return ([NSString stringWithFormat:@"price: $%@", self.formattedPrice]);
}


#pragma mark - JSONModel Methods

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
