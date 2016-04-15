//
//  BusinessesMapViewControllerDataSource.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/6/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "BusinessesMapViewControllerDataSource.h"
#import "BusinessesListTableViewController.h"
#import "MapAnnotation.h"
#import "YelpBusiness.h"
#import "YelpLocation.h"
#import "YelpDeal.h"
#import "YelpCategory.h"
#import "MapUtility.h"
#import "MapAnnotationView.h"

static NSString *const ReuseIdentifierKey = @"singleAnnotationView";

@implementation BusinessesMapViewControllerDataSource

- (id)initWithMapView:(MKMapView *)mapView {
    self = [super init];
    
    if (self) {
        self.mapView = mapView;
        self.mapView.delegate = self;
    }
    return self;
}

- (void)setupViewAndUseCurrentLocation:(BOOL)useCurrentLocation {
    
    //Remove all map annotations, if any
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    NSMutableSet *annotationsToAdd = [[NSMutableSet alloc] init];
    
    for (YelpBusiness *business in self.businessesArray) {
        
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:business.location.coordinate.coordLatitude longitude:business.location.coordinate.coordLongitude];
        
        if (useCurrentLocation) {
            //Center map at user location
            [MapUtility centerMap:self.mapView atLocation:self.currentLocation.coordinate zoomLevel:kDefaultMapZoomLevel];

        } else {
            //Center map at first object result location
            if (self.businessesArray.firstObject) {
                [MapUtility centerMap:self.mapView atLocation:loc.coordinate zoomLevel:kDefaultMapZoomLevel];
            }
        }

        MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:loc.coordinate];
        annotation.name = business.name;
        annotation.address = [NSString stringWithFormat:@"%@, %@", business.location.address.firstObject, business.location.city];
        annotation.phone = business.displayPhone;
        annotation.ratingImageUrl = business.ratingImgUrlSmall;
        annotation.reviews = [NSString stringWithFormat:@"%@ reviews", business.reviewCount];

        NSNumber *distance = [NSNumber numberWithFloat: business.distanceInMeters.floatValue*3.2808f/5280.0f];
        annotation.distance = [NSString stringWithFormat:@"%.2f mi", distance.floatValue];
        
        YelpCategory *category = business.categories.firstObject;
        
        if (business.categories.count >1) {
            YelpCategory *category2 = business.categories.lastObject;
            
            annotation.category = [NSString stringWithFormat:@"%@, %@", category.name, category2.name];

        } else {
            annotation.category = [NSString stringWithFormat:@"%@", category.name];
        }

        [annotationsToAdd addObject:annotation];
        
    }
    
    [self.mapView addAnnotations:[annotationsToAdd allObjects]];
}

#pragma mark - map delegate

- (MapAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(MapAnnotation *)annotation


{
    MapAnnotationView *annotationView;
    
    //RE: use the default blue dot for user location
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if([annotation isKindOfClass:[MapAnnotation class]]){
        
        MapAnnotation *singleAnnotation = (MapAnnotation *)annotation;
        
        annotationView = (MapAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:ReuseIdentifierKey];
        
        if (!annotationView) {
            annotationView = [[MapAnnotationView alloc] initWithAnnotation:singleAnnotation reuseIdentifier:ReuseIdentifierKey];
            
            annotationView.canShowCallout = NO;
            
            annotationView.nameLabel.text = singleAnnotation.name;
            annotationView.addressLabel.text = singleAnnotation.address;
            annotationView.phoneLabel.text = singleAnnotation.phone;
            annotationView.ratingsImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:singleAnnotation.ratingImageUrl]]];
            annotationView.reviewsLabel.text = singleAnnotation.reviews;
            annotationView.categoryLabel.text = singleAnnotation.category;
            annotationView.availabilityStatusLabel.text = singleAnnotation.availabilityStatus;
            annotationView.distanceLabel.text = singleAnnotation.distance;
            
            //show default annotationView image
            annotationView.image = [UIImage imageNamed:kMapMarkerRed];
        }
        
        annotationView.AnnotationSelectedBlock = ^{
            
            [MapUtility centerMap:aMapView atLocation:singleAnnotation.coordinate];
        };
        
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MapAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    //RE: TODO: use this to show the photos detail view
    NSLog(@"annotation accessory= %@ control =%@",view, control);
    
    [self showStoreItemsScreen];
    
}

- (MKOverlayRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id)overlay {
    if([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer* aRenderer = [[MKCircleRenderer
                                        alloc]initWithCircle:(MKCircle *)overlay];
        
        aRenderer.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.25];
        aRenderer.alpha = 0.5;
        
        return aRenderer;
        
    } else {
        return nil;
    }
}

- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated{
    [self.mapView removeOverlays:self.mapView.overlays];
//    [self.mapView doClustering];
}

#pragma mark - StoreItemsTableViewController

- (void)showStoreItemsScreen {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:StoryboardName.main bundle:nil];
    
    BusinessesListTableViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:ScreenStoryboardId.businessesListTableViewController];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
