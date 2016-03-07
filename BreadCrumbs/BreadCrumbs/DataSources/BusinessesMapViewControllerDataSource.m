//
//  BusinessesMapViewControllerDataSource.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/6/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "BusinessesMapViewControllerDataSource.h"
#import "MapAnnotation.h"
@import OCMapView;
#import "BusinessesListTableViewController.h"


//RE: TODO: change this later
static NSString *const kTYPE1 = @"Banana";
static NSString *const kTYPE2 = @"Orange";

@implementation BusinessesMapViewControllerDataSource

- (id)initWithMapView:(OCMapView *)mapView {
    self = [super init];
    
    if (self) {
        self.mapView = mapView;
        self.mapView.delegate = self;
    }
    return self;
}

#pragma mark - map delegate

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView;
    
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
    }
    // If it's a single annotation
    else if([annotation isKindOfClass:[MapAnnotation class]]){
        MapAnnotation *singleAnnotation = (MapAnnotation *)annotation;
        annotationView = (MKAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:@"singleAnnotationView"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:singleAnnotation reuseIdentifier:@"singleAnnotationView"];
            annotationView.canShowCallout = YES;
            annotationView.centerOffset = CGPointMake(0, -20);
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        singleAnnotation.title = singleAnnotation.groupTag;
        
        if ([singleAnnotation.groupTag isEqualToString:kTYPE1]) {
            annotationView.image = [UIImage imageNamed:@"icon_banana.png"];
        }
        else if([singleAnnotation.groupTag isEqualToString:kTYPE2]){
            annotationView.image = [UIImage imageNamed:@"icon_orange.png"];
        }
    }
    // Error
    else{
        annotationView = (MKPinAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:@"errorAnnotationView"];
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"errorAnnotationView"];
            annotationView.canShowCallout = NO;
            //            ((MKPinAnnotationView *)annotationView).pinColor = MKPinAnnotationColorRed;
        }
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    //RE: TODO: use this to show the photos detail view
    NSLog(@"annotation accessory= %@ control =%@",view, control);
    
    [self showStoreItemsScreen];
    
}


//- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
//    MKCircle *circle = overlay;
//    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
//
//    if ([circle.title isEqualToString:@"background"])
//    {
//        circleView.fillColor = [UIColor yellowColor];
//
//        circleView.alpha = 0.25;
//    }
//    else if ([circle.title isEqualToString:@"helper"])
//    {
//        circleView.fillColor = [UIColor redColor];
//        circleView.alpha = 0.25;
//    }
//    else
//    {
//        circleView.strokeColor = [UIColor blackColor];
//        circleView.lineWidth = 0.5;
//    }
//
//    return circleView;
//}

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
