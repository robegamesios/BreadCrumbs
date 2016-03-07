//
//  YelpGiftCertificateOptions.h
//  iosChatClient
//
//  Created by Daniel F Wyatt on 11/3/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

/*******************  FROM YELP ***********************
 

 gift_certificates.options	list	Gift certificate options
 gift_certificates.options.price	number	Gift certificate option price (in cents)
 gift_certificates.options.formatted_price	string	Gift certificate option price (formatted, e.g. "$50")
 

 "options": [
 {
 "formatted_price": "$25",
 "price": 2500
 },
 {
 "formatted_price": "$50",
 "price": 5000
 }
 ]
 
 ************************************************************/

#import "JSONModel.h"

@protocol YelpGiftCertificateOptions

@end

@interface YelpGiftCertificateOptions : JSONModel


//number  Gift certificate option price (in cents)
@property (strong, nonatomic) NSNumber *price;

//string	Gift certificate option price (formatted, e.g. "$50")
@property (strong, nonatomic) NSString *formattedPrice;

-(NSString*)description;

@end
