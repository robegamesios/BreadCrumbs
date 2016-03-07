//
//  YelpReviewUser.h
//  iosChatClient
//
//  Created by Daniel F Wyatt on 11/3/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//
/***************** FROM YELP **********************************

 reviews.user	dict	User who wrote the review
 reviews.user.id	string	User identifier
 reviews.user.image_url	url	User profile image url
 reviews.user.name	string	User name

 "user": {
 "id": "AUEDVbP9XNlOcgYOAfR8yg",
 "image_url": "http://s3-media2.ak.yelpcdn.com/photo/0CX0RSoz8NkPlOTo7Ckqdg/ms.jpg",
 "name": "Holly E."
 }
 
 **************************************************************/

#import "JSONModel.h"

@interface YelpReviewUser : JSONModel

//string    User identifier
@property (strong, nonatomic) NSString *userId;

//url	User profile image url
@property (strong, nonatomic) NSString *imageUrl;

//string	User name
@property (strong, nonatomic) NSString *name;

@end
