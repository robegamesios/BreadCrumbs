//
//  YelpGiftCertificate.h
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

/*******************  FROM YELP ***********************
 
 /*
 gift_certificates	list	Gift certificate info for this business (optional: this field is present only if there are gift certificates available)
 gift_certificates.id	string	Gift certificate identifier
 gift_certificates.url	url	Gift certificate landing page url
 gift_certificates.image_url	url	Gift certificate image url
 gift_certificates.currency_code	string	ISO_4217 Currency Code
 gift_certificates.unused_balances	string	Whether unused balances are returned as cash or store credit
 gift_certificates.options	list	Gift certificate options
 gift_certificates.options.price	number	Gift certificate option price (in cents)
 gift_certificates.options.formatted_price	string	Gift certificate option price (formatted, e.g. "$50")
 
 "gift_certificates": [
 {
 "currency_code": "USD",
 "image_url": "http://s3-media4.ak.yelpcdn.com/bphoto/Hv5vsWpqeaUKepr9nffJnw/m.jpg",
 "options": [
 {
 "formatted_price": "$25",
 "price": 2500
 },
 {
 "formatted_price": "$50",
 "price": 5000
 }
 ],
 "url": "http://www.yelp.com/gift-certificates/some-donut-place-pasadena",
 "id": "ZZy5EwrI3wyHw8y54jZruA",
 "unused_balances": "CREDIT"
 }
 ],  

************************************************************/

#import "JSONModel.h"
#import "YelpGiftCertificateOptions.h"


@protocol YelpGiftCertificate

@end

@interface YelpGiftCertificate : JSONModel

//string	Deal option title
@property (strong, nonatomic) NSString *title;

//string	Gift certificate identifier
@property (strong, nonatomic) NSString *certificateId;

//url	Gift certificate landing page url
@property (strong, nonatomic) NSString *url;

//url	Gift certificate image url
@property (strong, nonatomic) NSString *imageUrl;

//string	ISO_4217 Currency Code
@property (strong, nonatomic) NSString *currencyCode;

//string	Whether unused balances are returned as cash or store credit
@property (strong, nonatomic) NSString *unusedBalances;

//list	Gift certificate options
@property (strong, nonatomic) NSArray<YelpGiftCertificateOptions> *options;


@end
