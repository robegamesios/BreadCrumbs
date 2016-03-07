//
//  BusinessesMapViewController.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 2/17/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "BusinessesMapViewController.h"
#import "MapAnnotation.h"
@import OCMapView;
#import "BusinessesMapViewControllerDataSource.h"

//RE: TODO: change this later
static NSString *const kTYPE1 = @"Banana";
static NSString *const kTYPE2 = @"Orange";
static CGFloat kDEFAULTCLUSTERSIZE = 0.2;

@interface BusinessesMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet OCMapView *mapView;
@property (strong, nonatomic) BusinessesMapViewControllerDataSource *dataSource;

@end

@implementation BusinessesMapViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataSource];
    [self setupView];
}

#pragma mark - Accessors

- (BusinessesMapViewControllerDataSource *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [[BusinessesMapViewControllerDataSource alloc]initWithMapView:self.mapView];
    }
    return _dataSource;
}


#pragma mark - Setup

- (void)setupDataSource {
    self.dataSource.navigationController = self.navigationController;
}

- (void)setupView {

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


@end
