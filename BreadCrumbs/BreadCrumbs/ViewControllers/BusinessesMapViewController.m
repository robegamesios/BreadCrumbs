//
//  BusinessesMapViewController.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 2/17/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "BusinessesMapViewController.h"
#import "BusinessesMapViewControllerDataSource.h"
#import "MapAnnotation.h"
#import "MapUtility.h"
#import "NetworkService.h"
@import OCMapView;
#import "YelpBusiness.h"
#import "YelpLocation.h"


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
    
    [self setupUserLocation];
    [self setupDataSource];
    [self testJSON];
}

#pragma mark - Accessors

- (BusinessesMapViewControllerDataSource *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [[BusinessesMapViewControllerDataSource alloc]initWithMapView:self.mapView];
    }
    return _dataSource;
}


#pragma mark - Setup

- (void)setupUserLocation {
    
    if ([[SingletonLocalService sharedManager] isLocationServicesAvailable]) {
        [[SingletonLocalService sharedManager] getUserLocationWithSuccessHandler:^(id responseObject) {
            CLLocation *result = responseObject;
            [MapUtility centerMap:self.mapView atLocation:result.coordinate zoomLevel:1.0f];
        }];
        
    } else {
        NSLog(@"%@",[GlobalLocalizations localizedFaildToGetUserLocation]);
    }
    
}

- (void)testJSON {
    
    __weak typeof(self) weakSelf = self;
    
    [[NetworkService sharedNetworkService] queryStoreWithType:@"food" location:@"san francisco" successHandler:^(id responseObject) {
        
        NSArray *array = [NSArray arrayWithArray:responseObject];
        weakSelf.dataSource.businessesArray = array;
        
        [weakSelf.dataSource setupView];

    } errorHandler:^(NSString *errorString) {
        NSLog(@"JSON Network error = %@", errorString);
    }];
}

- (void)setupDataSource {
    self.dataSource.navigationController = self.navigationController;
}

- (void)setupView {
    
    self.mapView.clusterSize = kDEFAULTCLUSTERSIZE;

    NSMutableSet *annotationsToAdd = [[NSMutableSet alloc] init];
    
    for (YelpBusiness *business in self.dataSource.businessesArray) {

        CLLocation *loc = [[CLLocation alloc]initWithLatitude:business.location.coordinate.coordLatitude longitude:business.location.coordinate.coordLongitude];

        MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:loc.coordinate];

        // add to group if specified
        if (annotationsToAdd.count < (self.dataSource.businessesArray.count)/2.0) {
            annotation.groupTag = kTYPE1;
        } else {
            annotation.groupTag = kTYPE2;
        }
        [annotationsToAdd addObject:annotation];

    }
    
    [self.mapView addAnnotations:[annotationsToAdd allObjects]];

}

@end
