//
//  YelpDeal-Options.h
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/31/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//


/********************** FROM YELP ************************
options	list	Deal options
options.title	string	Deal option title
options.purchase_url	url	Deal option url for purchase
options.price	number	Deal option price (in cents)
options.formatted_price	string	Deal option price (formatted, e.g. "$6")
options.original_price	number	Deal option original price (in cents)
options.formatted_original_price	string	Deal option original price (formatted, e.g. "$12")
options.is_quantity_limited	bool	Whether the deal option is limited or unlimited
options.remaining_count	number	The remaining deal options available for purchase (optional: this field is only present if the deal is limited)
 
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

  ********************** FROM YELP ************************/

#import "JSONModel.h"

@interface YelpDealOptions : JSONModel

//string	Deal option title
@property (strong, nonatomic) NSString *title;

//url	Deal option url for purchase
@property (strong, nonatomic) NSString *purchaseUrl;

//number  Deal option price (in cents)
@property (strong, nonatomic) NSNumber *price;

//string	Deal option price (formatted, e.g. "$6")
@property (strong, nonatomic) NSString *formattedPrice;

//number	Deal option original price (in cents)
@property (strong, nonatomic) NSNumber *originalPrice;

//string	Deal option original price (formatted, e.g. "$12")
@property (strong, nonatomic) NSString *formattedOriginalPrice;

//bool	Whether the deal option is limited or unlimited
@property (assign, nonatomic) BOOL isQuantityLimited;

//number	The remaining deal options available for purchase (optional: this field is only present if the deal is limited)
@property (strong, nonatomic) NSString<Optional> *remainingCount;

-(NSString*)description;

@end
