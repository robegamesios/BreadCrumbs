//
//  MapListContainerViewController.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/11/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "MapListContainerViewController.h"
#import "BusinessesListTableViewController.h"
#import "BusinessesMapViewController.h"
#import "SearchViewController.h"

static NSString *const ListIconKey = @"list-icon";
static NSString *const LocationIconKey = @"location-icon";

@interface MapListContainerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *toggleButton;

@property (strong, nonatomic) BusinessesListTableViewController *listTableViewController;
@property (strong, nonatomic) BusinessesMapViewController *mapViewController;

@end

@implementation MapListContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
}


#pragma mark - Accessors

- (BusinessesListTableViewController *)listTableViewController {
    
    if (!_listTableViewController) {
        _listTableViewController = (BusinessesListTableViewController *)[UIStoryboard instantiateViewControllerWithStoryboardName:StoryboardName.main screenStoryboardId:ScreenStoryboardId.businessesListTableViewController];
        
    }
    return _listTableViewController;
}

- (BusinessesMapViewController *)mapViewController {
    
    if (!_mapViewController) {
        _mapViewController = (BusinessesMapViewController *)[UIStoryboard instantiateViewControllerWithStoryboardName:StoryboardName.main screenStoryboardId:ScreenStoryboardId.businessesMapViewController];
    }
    return _mapViewController;
}

- (void)setupView {
    [self.view addSubview:self.listTableViewController.view];
    [self.view addSubview:self.mapViewController.view];
    
    [self showMapViewScreen];
}


#pragma mark - Methods

- (void)showListViewScreen {
    self.listTableViewController.view.hidden = NO;
    self.mapViewController.view.hidden = YES;
    
    UIImage *image = [UIImage imageNamed:LocationIconKey];
    
    [self.toggleButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)showMapViewScreen {
    self.listTableViewController.view.hidden = YES;
    self.mapViewController.view.hidden = NO;
    
    UIImage *image = [UIImage imageNamed:ListIconKey];
    
    [self.toggleButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)showSearchViewScreen {
    SearchViewController *searchViewController = (SearchViewController *)[UIStoryboard instantiateViewControllerWithStoryboardName:StoryboardName.main screenStoryboardId:ScreenStoryboardId.searchViewController];
    
    
//    GMSAutocompleteViewController *searchViewController = [[GMSAutocompleteViewController alloc] init];
//    searchViewController.delegate = self;
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:searchViewController];

    [self presentViewController:navigationController animated:YES completion:nil];
}


#pragma mark - GoogleMaps Delegate Methods

//- (void)viewController:(GMSAutocompleteViewController *)viewController
//didAutocompleteWithPlace:(GMSPlace *)place {
//    // Do something with the selected place.
//    NSLog(@"Place name %@", place.name);
//    NSLog(@"Place address %@", place.formattedAddress);
//    NSLog(@"Place attributions %@", place.attributions.string);
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)viewController:(GMSAutocompleteViewController *)viewController
//didFailAutocompleteWithError:(NSError *)error {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    // TODO: handle the error.
//    NSLog(@"Error: %@", [error description]);
//}
//
//// User canceled the operation.
//- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//// Turn the network activity indicator on and off again.
//- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//}
//
//- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//}


#pragma mark - IBActions

- (IBAction)toggleButtonTapped:(UIButton *)sender {
    void (^Animations)(void) = ^{
        if(self.listTableViewController.view.hidden) {
            [self showListViewScreen];
        } else {
            [self showMapViewScreen];
        }
    };
    
    //RE: Add Flip Animation L to R / R to L
    [UIView transitionWithView:self.view
                      duration:1.f
                       options:(self.listTableViewController.view.hidden ? UIViewAnimationOptionTransitionFlipFromRight :
                                UIViewAnimationOptionTransitionFlipFromLeft)
                    animations:Animations
     
                    completion:nil];
}

- (IBAction)searchButtonTapped:(UIButton *)sender {
    [self showSearchViewScreen];
}


@end
