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
@import OCMapView;
#import "YelpBusiness.h"
#import "YelpLocation.h"
#import "MapUtility.h"


//RE: TODO: change this later
static NSString *const kTYPE1 = @"Banana";
static NSString *const kTYPE2 = @"Orange";
static CGFloat kDEFAULTCLUSTERSIZE = 0.2;

static NSString *const ReuseIdentifierKey = @"singleAnnotationView";

@implementation BusinessesMapViewControllerDataSource

- (id)initWithMapView:(OCMapView *)mapView {
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
    
    self.mapView.clusterSize = kDEFAULTCLUSTERSIZE;
    
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
        annotation.title = business.name;
        annotation.subtitle = business.phone;
        annotation.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:business.imageUrl]]];
        
        // add to group if specified
        if (annotationsToAdd.count < (self.businessesArray.count)/2.0) {
            annotation.groupTag = kTYPE1;
        } else {
            annotation.groupTag = kTYPE2;
        }
        [annotationsToAdd addObject:annotation];
        
    }
    
    [self.mapView addAnnotations:[annotationsToAdd allObjects]];
}

#pragma mark - map delegate

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(MapAnnotation *)annotation
{
    MKAnnotationView *annotationView;

    //RE: use the default blue dot for user location
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    // if it's a cluster
    if ([annotation isKindOfClass:[OCAnnotation class]]) {
        
        OCAnnotation *clusterAnnotation = (OCAnnotation *)annotation;
        
        annotationView = (MKAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:@"ClusterView"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ClusterView"];
            annotationView.canShowCallout = YES;
            annotationView.centerOffset = CGPointMake(0, -20);
        }
        
        // set title
        clusterAnnotation.title = @"Cluster";
        clusterAnnotation.subtitle = [NSString stringWithFormat:@"Containing annotations: %zd", [clusterAnnotation.annotationsInCluster count]];
        
        // set its image
        annotationView.image = [UIImage imageNamed:@"icon_regular.png"];
        
        // change pin image for group
        if (self.mapView.clusterByGroupTag) {
            if ([clusterAnnotation.groupTag isEqualToString:kTYPE1]) {
                annotationView.image = [UIImage imageNamed:@"icon_bananas.png"];
            }
            else if([clusterAnnotation.groupTag isEqualToString:kTYPE2]){
                annotationView.image = [UIImage imageNamed:@"icon_oranges.png"];
            }
            clusterAnnotation.title = clusterAnnotation.groupTag;
        }
        
        //show radius of cluster
        //TODO: set the radius size based on the cluster size perimeter
        MKCircle *circleoverlay = [MKCircle circleWithCenterCoordinate:annotation.coordinate radius:100];
        [aMapView addOverlay:circleoverlay];

    }
    
    // If it's a single annotation
    else if([annotation isKindOfClass:[MapAnnotation class]]){
        
        MapAnnotation *singleAnnotation = (MapAnnotation *)annotation;
        
        annotationView = (MKAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:ReuseIdentifierKey];
        
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:singleAnnotation reuseIdentifier:ReuseIdentifierKey];
            annotationView.canShowCallout = YES;
            annotationView.centerOffset = CGPointMake(0, -20);
            
            //show default annotationView image
            annotationView.image = [UIImage imageNamed:kMapMarkerRed];
            
            //shows a right accessory button
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            //shows an image on the left side of annotationView
            annotationView.leftCalloutAccessoryView =  [[UIImageView alloc] initWithImage:annotation.image];
        }
    }
    
    // Error
    else {
        //TODO: might not be need, maybe show alert controller instead
        annotationView = (MKPinAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:@"errorAnnotationView"];
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"errorAnnotationView"];
            annotationView.canShowCallout = NO;
        }
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
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
    [self.mapView doClustering];
}

#pragma mark - StoreItemsTableViewController

- (void)showStoreItemsScreen {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:StoryboardName.main bundle:nil];
    
    BusinessesListTableViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:ScreenStoryboardId.businessesListTableViewController];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
