//
//  YelpLocation.h
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/28/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

#import "JSONModel.h"
#import "YelpDeal.h"
#import "YelpGiftCertificate.h"
#import "YelpCategory.h"
#import "YelpLocation.h"
#import "YelpReview.h"


@interface YelpBusiness : JSONModel

/**** JSON/DICT POPULATED; Converted _ case to camelCase from MongoDB by JSONModel
*
*  All of this information can be found here:
*  http://www.yelp.com/developers/documentation/v2/business
*
 ***/

//Yelp ID for this business
@property (strong, nonatomic) NSString *yelpId;

//Whether business has been claimed by a business owner
@property (assign, nonatomic) BOOL isClaimed;

//Whether business has been (permanently) closed
@property (assign, nonatomic) BOOL isClosed;

//Name of this business
@property (strong, nonatomic) NSString *name;

//URL of photo for this business
@property (strong, nonatomic) NSString *imageUrl;

//URL for business page on Yelp
@property (strong, nonatomic) NSString *url;

//URL for mobile business page on Yelp
@property (strong, nonatomic) NSString *mobileUrl;

//Phone number for this business with international dialing code (e.g. +442079460000)
@property (strong, nonatomic) NSString<Optional> *phone;

//Phone number for this business formatted for display
@property (strong, nonatomic) NSString<Optional> *displayPhone;

//Number of reviews for this business
@property (strong, nonatomic) NSNumber *reviewCount;

//Provides a list of category name, alias pairs that this business is associated with. For example,
//[["Local Flavor", "localflavor"], ["Active Life", "active"], ["Mass Media", "massmedia"]]
//The alias is provided so you can search with the category_filter.
@property (strong, nonatomic) NSArray<YelpCategory> *categories;



//Distance that business is from search location in meters, if a latitude/longitude is specified.
//@property (strong, nonatomic) NSNumber *distanceInMeters;



//Rating for this business (value ranges from 1, 1.5, ... 4.5, 5)
@property (strong, nonatomic) NSNumber *rating;

//URL to star rating image for this business (size = 84x17)
@property (strong, nonatomic) NSString *ratingImgUrl;

//URL to small version of rating image for this business (size = 50x10)
@property (strong, nonatomic) NSString *ratingImgUrlSmall;

//URL to large version of rating image for this business (size = 166x30)
@property (strong, nonatomic) NSString *ratingImgUrlLarge;

//Snippet text associated with this business
@property (strong, nonatomic) NSString *snippetText;

//URL of snippet image associated with this business
@property (strong, nonatomic) NSString *snippetImgUrl;

//Location data for this business  - SEE CUSTOM CLASS
@property (strong, nonatomic) YelpLocation *location;

//Deal info for this business (optional: this field is present only if there’s a Deal)
@property (strong, nonatomic) NSArray<YelpDeal,Optional> *deals;

//Gift certificate info for this business (optional: this field is present only if there are gift certificates available)
#warning Incomplete JSON declaration / implementation.
@property (strong, nonatomic) NSArray<YelpGiftCertificate,Ignore> *giftCertificates;

//Provider of the menu for this business
@property (strong, nonatomic) NSString<Optional> *menuProvider;

//Last time this menu was updated on Yelp (Unix timestamp)
@property (strong, nonatomic) NSDate<Optional> *menuDateUpdated;

//Contains one review associated with business
#warning Need to Go Clean up the YelpReviewClass
@property (strong, nonatomic) NSArray<YelpReview,Optional> *reviews;

- (void)toString;
- (void)setCategoriesWithNSArray:(NSArray*)array;

@end
