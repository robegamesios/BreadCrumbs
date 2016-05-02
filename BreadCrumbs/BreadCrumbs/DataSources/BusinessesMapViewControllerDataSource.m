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
    
    NSMutableArray *annotationsToAdd = [[NSMutableArray alloc] init];
    
    for (YelpBusiness *business in self.businessesArray) {
        
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:business.location.coordinate.coordLatitude longitude:business.location.coordinate.coordLongitude];
        
        MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:loc.coordinate];
        annotation.name = business.name;
        annotation.address = [NSString stringWithFormat:@"%@, %@", business.location.address.firstObject, business.location.city];
        annotation.phone = business.displayPhone;
        annotation.ratingImageUrl = business.ratingImgUrlSmall;
        annotation.reviews = [NSString stringWithFormat:@"%@ reviews", business.reviewCount];

        if (business.distanceInMeters) {
            NSNumber *distance = [NSNumber numberWithFloat: business.distanceInMeters.floatValue*3.2808f/5280.0f];
            annotation.distance = [NSString stringWithFormat:@"%.2f mi", distance.floatValue];
            
        }
        
        YelpCategory *category = business.categories.firstObject;
        
        if (business.categories.count >1) {
            YelpCategory *category2 = business.categories.lastObject;
            
            annotation.category = [NSString stringWithFormat:@"%@, %@", category.name, category2.name];

        } else if (business.categories.count) {
            annotation.category = [NSString stringWithFormat:@"%@", category.name];
        }

        
        YelpDeal *deal = business.deals.firstObject;

        if (deal) {
            annotation.deal = [NSString stringWithFormat:@"%@", deal.title];
        }
        
        [annotationsToAdd addObject:annotation];
        
    }
    
    if (useCurrentLocation) {
        //Center map at user location
        [MapUtility centerMap:self.mapView atLocation:self.currentLocation.coordinate zoomLevel:kDefaultMapZoomLevel];
        
    } else {
        //Center map at first object result location
        if (annotationsToAdd.firstObject) {
            
            MapAnnotation *loc = annotationsToAdd.firstObject;
            
            [MapUtility centerMap:self.mapView atLocation:loc.coordinate zoomLevel:kDefaultMapZoomLevel];
        }
    }

    [self.mapView addAnnotations:annotationsToAdd];
}

#pragma mark - map delegate

- (MapAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(MapAnnotation *)annotation {
    
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
            
            //show default annotationView image
            annotationView.image = [UIImage imageNamed:kMapMarkerRed];
        }

        annotationView.nameLabel.text = singleAnnotation.name;
        annotationView.addressLabel.text = singleAnnotation.address;
        annotationView.phoneLabel.text = singleAnnotation.phone;
        annotationView.ratingsImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:singleAnnotation.ratingImageUrl]]];
        annotationView.reviewsLabel.text = singleAnnotation.reviews;
        annotationView.categoryLabel.text = singleAnnotation.category;
        annotationView.dealsLabel.text = singleAnnotation.deal;
        annotationView.distanceLabel.text = singleAnnotation.distance;

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
