//
//  YelpDeal.h
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

/* *****************  FROM YELP :: **************************

 deals	list	Deal info for this business (optional: this field is present only if there’s a Deal)
 id	string	Deal identifier
 title	string	Deal title
 url	url	Deal url
 image_url	url	Deal image url
 currency_code	string	ISO_4217 Currency Code
 time_start	number	Deal start time (Unix timestamp)
 time_end	number	Deal end time (optional: this field is present only if the Deal ends)
 is_popular	bool	Whether the Deal is popular (optional: this field is present only if true)
 what_you_get	string	Additional details for the Deal, separated by newlines
 important_restrictions	string	Important restrictions for the Deal, separated by newlines
 additional_restrictions	string	Deal additional restrictions
 options	list	Deal options
 options.title	string	Deal option title
 options.purchase_url	url	Deal option url for purchase
 options.price	number	Deal option price (in cents)
 options.formatted_price	string	Deal option price (formatted, e.g. "$6")
 options.original_price	number	Deal option original price (in cents)
 options.formatted_original_price	string	Deal option original price (formatted, e.g. "$12")
 options.is_quantity_limited	bool	Whether the deal option is limited or unlimited
 options.remaining_count	number	The remaining deal options available for purchase (optional: this field is only present if the deal is limited)
 
 "deals": [
 {
 "currency_code": "USD",
 "image_url": "http://s3-media4.ak.yelpcdn.com/dphoto/ShQGf5qi-52HwPiKyZTZ3w/m.jpg",
 "options": [
 {
 "formatted_original_price": "$20",
 "formatted_price": "$10",
 "is_quantity_limited": true,
 "original_price": 2000,
 "price": 1000,
 "purchase_url": "http://www.yelp.com/deal/cC24ccQGIH8mowfu5Vbe0Q/view",
 "remaining_count": 36,
 "title": "$10 for $20 voucher"
 }
 ],
 "url": "http://www.yelp.com/biz/urban-curry-san-francisco?deal=1",
 "is_popular": true,
 "time_start": 1317414369,
 "title": "$10 for $20 voucher"
 }
 ]
 

 
  *****************  FROM YELP :: **************************/

#import "JSONModel.h"
#import "YelpDealOptions.h"


@protocol YelpDeal

@end


@interface YelpDeal : JSONModel

//string	Deal identifier
@property (strong, nonatomic) NSString *dealId;

//string	Deal title
@property (strong, nonatomic) NSString *title;

//url	Deal url
@property (strong, nonatomic) NSString *url;

//url	Deal image url
@property (strong, nonatomic) NSString *imageUrl;

//string	ISO_4217 Currency Code
@property (strong, nonatomic) NSString *currencyCode;

//number	Deal start time (Unix timestamp)
@property (strong, nonatomic) NSDate *timeStart;

//number	Deal end time (optional: this field is present only if the Deal ends)
@property (strong, nonatomic) NSDate<Optional> *timeEnd;

//bool	Whether the Deal is popular (optional: this field is present only if true)
@property (strong, nonatomic) NSNumber<Optional> *isPopular;

//string	Additional details for the Deal, separated by newlines
@property (strong, nonatomic) NSString *whatYouGet;

//string	Important restrictions for the Deal, separated by newlines
@property (strong, nonatomic) NSString *importantRestrictions;

//string	Deal additional restrictions
@property (strong, nonatomic) NSString *additionalRestrictions;

//Deal options - SEE CUSTOM CLASS
@property (strong, nonatomic) YelpDealOptions *options;

//This is a custom function to set options from the incoming Array... Silly YELP
- (void)setOptionsWithNSArray:(NSArray*)array;


@end
