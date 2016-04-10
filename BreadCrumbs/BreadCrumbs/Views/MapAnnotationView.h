//
//  MapAnnotationView.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 4/8/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapAnnotationView : MKAnnotationView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *starRatingLabel;

@property (copy, nonatomic) VoidBlock AnnotationSelectedBlock;


@end
