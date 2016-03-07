//
//  YelpCategory.h
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "JSONModel.h"

/*
 
 categories =             (
 
 (
 
 Delis,
 
 delis
 
 ),
 
 */

@protocol YelpCategory

@end

@interface YelpCategory : NSObject

@property (strong, nonatomic) NSString<Optional> *name;
@property (strong, nonatomic) NSString<Optional> *alias;

-(NSString*)description;

@end
