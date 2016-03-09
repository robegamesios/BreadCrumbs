//
//  BusinessesMapViewController.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 2/17/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "BusinessesMapViewController.h"
@import OCMapView;
#import "MapAnnotation.h"
#import "BusinessesMapViewControllerDataSource.h"
#import "NetworkService.h"
#import "YelpBusiness.h"
#import "YelpLocation.h"
#import "MapUtility.h"
#import <INTULocationManager/INTULocationManager.h>


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
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.f block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        
        if (status == INTULocationStatusSuccess) {
            
            [MapUtility centerMap:self.mapView atLocation:currentLocation.coordinate zoomLevel:1.0f];

        } else if (status == INTULocationStatusTimedOut) {
            
        } else {
            
        }
    }];
}

- (void)testJSON {
    
    __weak typeof(self) weakSelf = self;
    
    [[NetworkService sharedNetworkService] queryStoreWithType:@"food" location:@"san francisco" successHandler:^(id responseObject) {
        
        NSArray *array = [NSArray arrayWithArray:responseObject];
        weakSelf.dataSource.businessesArray = array;
        
        [weakSelf setupView];

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
