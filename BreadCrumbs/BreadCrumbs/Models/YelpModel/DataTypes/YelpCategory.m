//
//  YelpCategory.m
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "YelpCategory.h"

@implementation YelpCategory

-(NSString*)description {
    
    return [NSString stringWithFormat:@"name: '%@'  alias: '%@'", self.name, self.alias];

}

@end
