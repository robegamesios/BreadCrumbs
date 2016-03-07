//
//  YelpReview.h
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

/***************** FROM YELP **********************************
 
 reviews	list	Contains one review associated with business
 reviews.id	string	Review identifier
 reviews.rating	number	Rating from 1-5
 reviews.rating_image_url	url	URL to star rating image for this business (size = 84x17)
 reviews.rating_image_small_url	url	URL to small version of rating image for this business (size = 50x10)
 reviews.rating_image_large_url	url	URL to large version of rating image for this business (size = 166x30)
 reviews.excerpt	string	Review excerpt
 reviews.time_created	number	Time created (Unix timestamp)
 reviews.user	dict	User who wrote the review
 reviews.user.id	string	User identifier
 reviews.user.image_url	url	User profile image url
 reviews.user.name	string	User name
 
 "reviews": [
 {
 "excerpt": "I gave this restaurant two stars just because of the extremely quick delivery and friendly delivery guy, but the food was nothing I would order again....",
 "id": "-RDZxLTUExM9Q02x4hZmHg",
 "rating": 2,
 "rating_image_large_url": "http://media2.ak.yelpcdn.com/static/20101216220207235/img/ico/stars/stars_large_2.png",
 "rating_image_small_url": "http://media4.ak.yelpcdn.com/static/201012164278297776/img/ico/stars/stars_small_2.png",
 "rating_image_url": "http://media4.ak.yelpcdn.com/static/201012163489049252/img/ico/stars/stars_2.png",
 "time_created": 1317939620,
 "user": {
 "id": "AUEDVbP9XNlOcgYOAfR8yg",
 "image_url": "http://s3-media2.ak.yelpcdn.com/photo/0CX0RSoz8NkPlOTo7Ckqdg/ms.jpg",
 "name": "Holly E."
 }
 }
 ],
 
 **************************************************************/

#import "JSONModel.h"
#import "YelpReviewUser.h"

@protocol YelpReview

@end

@interface YelpReview : JSONModel

//Provider of the menu for this business
@property (strong, nonatomic) NSString *yelpId;

//Rating for this business (value ranges from 1, 1.5, ... 4.5, 5)
@property (strong, nonatomic) NSNumber *rating;

//URL to star rating image for this business (size = 84x17)
@property (strong, nonatomic) NSString *ratingImgUrl;

//URL to small version of rating image for this business (size = 50x10)
@property (strong, nonatomic) NSString *ratingImgUrlSmall;

//URL to large version of rating image for this business (size = 166x30)
@property (strong, nonatomic) NSString *ratingImgUrlLarge;

//number	Time created (Unix timestamp)
@property (strong, nonatomic) NSDate *timeCreated;

//string	Review excerpt
@property (strong, nonatomic) NSString *excerpt;

//dict	User who wrote the review
@property (strong, nonatomic) YelpReviewUser *user;

@end
