//
//  YelpLocation.h
//  iosChatClient
//
//  Created by Daniel F Wyatt on 10/29/14.
//  Copyright (c) 2014 Daniel F Wyatt. All rights reserved.
//

//FROM YELP:
/*"location": {
 "address": [
 "523 Broadway"
 ],
 "city": "San Francisco",
 "country_code": "US",
 "cross_streets": "Kearny St & Romolo Pl",
 "display_address": [
 "523 Broadway",
 "(b/t Kearny St & Romolo Pl)",
 "North Beach/Telegraph Hill",
 "San Francisco, CA 94133"
 ],
 "neighborhoods": [
 "North Beach/Telegraph Hill"
 ],
 "postal_code": "94133",
 "state_code": "CA"
 },
 
 location	dict	Location data for this business
 location.address	list	Address for this business. Only includes address fields.
 location.display_address	list	Address for this business formatted for display. Includes all address fields, cross streets and city, state_code, etc.
 location.city	string	City for this business
 location.state_code	string	ISO 3166-2 state code for this business
 location.postal_code	string	Postal code for this business
 location.country_code	string	ISO 3166-1 country code for this business
 location.cross_streets	string	Cross streets for this business
 location.neighborhoods	list	List that provides neighborhood(s) information for business
 
 */

#import "JSONModel.h"

@protocol YelpLocation

@end

@interface YelpLocation : JSONModel

//Address for this business. Only includes address fields.
@property (strong, nonatomic) NSArray *address;

//Address for this business formatted for display. Includes all address fields, cross streets and city, state_code, etc.
@property (strong, nonatomic) NSArray *displayAddress;

//City for this business
@property (strong, nonatomic) NSString *city;

//ISO 3166-2 state code for this business
@property (strong, nonatomic) NSString *stateCode;

//Postal code for this business
@property (strong, nonatomic) NSString *postalCode;

//ISO 3166-1 country code for this business
@property (strong, nonatomic) NSString *countryCode;

//Cross streets for this business
@property (strong, nonatomic) NSString<Optional> *crossStreets;

//List that provides neighborhood(s) information for business
@property (strong, nonatomic) NSArray<Optional> *nieghborhoods;


@end
