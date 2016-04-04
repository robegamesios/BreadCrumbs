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

- (void)setupDataSource {
    self.dataSource.navigationController = self.navigationController;
}

- (void)updateResults {
    self.dataSource.businessesArray = self.resultArray;
    [self.dataSource setupView];
}

@end
