//
//  MapViewController.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 2/17/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "MapViewController.h"
#import "MapAnnotation.h"
#import "StoreItemsTableViewController.h"

//RE: TODO: change this later
static NSString *const kTYPE1 = @"Banana";
static NSString *const kTYPE2 = @"Orange";
static CGFloat kDEFAULTCLUSTERSIZE = 0.2;

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet OCMapView *mapView;

@end

@implementation MapViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {

    self.mapView.delegate = self;
    self.mapView.clusterSize = kDEFAULTCLUSTERSIZE;

    NSArray *randomLocations = [[NSArray alloc] initWithArray:[self randomCoordinatesGenerator:100]];
    NSMutableSet *annotationsToAdd = [[NSMutableSet alloc] init];
    
    for (CLLocation *loc in randomLocations) {
        MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:loc.coordinate];
        [annotationsToAdd addObject:annotation];
        
        // add to group if specified
        if (annotationsToAdd.count < (randomLocations.count)/2.0) {
            annotation.groupTag = kTYPE1;
        } else {
            annotation.groupTag = kTYPE2;
        }
        
    }
    
    [self.mapView addAnnotations:[annotationsToAdd allObjects]];

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

#pragma mark - Test Data Logic

// Help method which returns an array of random CLLocations
// You can specify the number of coordinates by setting numberOfCoordinates
- (NSArray *)randomCoordinatesGenerator:(int)numberOfCoordinates
{
    MKCoordinateRegion visibleRegion = self.mapView.region;
    visibleRegion.span.latitudeDelta *= 0.8;
    visibleRegion.span.longitudeDelta *= 0.8;
    
    int max = 9999;
    numberOfCoordinates = MAX(0,numberOfCoordinates);
    NSMutableArray *coordinates = [[NSMutableArray alloc] initWithCapacity:numberOfCoordinates];
    for (int i = 0; i < numberOfCoordinates; i++) {
        
        // start with top left corner
        CLLocationDistance longitude = visibleRegion.center.longitude - visibleRegion.span.longitudeDelta/2.0;
        CLLocationDistance latitude  = visibleRegion.center.latitude + visibleRegion.span.latitudeDelta/2.0;
        
        // Get random coordinates within current map rect
        longitude += ((arc4random()%max)/(CGFloat)max) * visibleRegion.span.longitudeDelta;
        latitude  -= ((arc4random()%max)/(CGFloat)max) * visibleRegion.span.latitudeDelta;
        
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        [coordinates addObject:loc];
    }
    return  coordinates;
}


#pragma mark - StoreItemsTableViewController

- (void)showStoreItemsScreen {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    StoreItemsTableViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"StoreItemsTableViewControllerStoryboardID"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
