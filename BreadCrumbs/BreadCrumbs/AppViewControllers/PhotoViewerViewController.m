//
//  PhotoViewerViewController.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 2/24/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "PhotoViewerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MWPhotoBrowser.h"
#import "MWCommon.h"
#import "SDImageCache.h"

@interface PhotoViewerViewController () <MWPhotoBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
//@property (nonatomic, strong) NSMutableArray *assets;

//@property (nonatomic, strong) PHPhotoLibrary *ALAssetsLibrary;

@end

@implementation PhotoViewerViewController

//UISegmentedControl *_segmentedControl;
NSMutableArray *_selections;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTestData];
}

- (void)showPhotoBrowser {
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = YES; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:0];

//    [self.navigationController presentViewController:browser animated:YES completion:nil];
    [self.navigationController pushViewController:browser animated:YES];
}


- (void)addTestData {
    
    self.photos = [NSMutableArray new];
    self.thumbs = [NSMutableArray new];
    
    MWPhoto *photo;
    
    photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"photo5.jpg"]];
    photo.caption = @"White Tower";
    [self.photos addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"photo2.jpg"]];
    photo.caption = @"The London Eye is a giant Ferris wheel situated on the banks of the River Thames, in London, England.";
    [self.photos addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"photo3.jpg"]];
    photo.caption = @"York Floods";
    [self.photos addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"photo4.jpg"]];
    photo.caption = @"Campervan";
    [self.photos addObject:photo];
    // Thumbs
    photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"photo5t.jpg"]];
    [self.thumbs addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"photo2t.jpg"]];
    [self.thumbs addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"photo3t.jpg"]];
    [self.thumbs addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"photo4t.jpg"]];
    [self.thumbs addObject:photo];

    
    [self showPhotoBrowser];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

//#pragma mark - Load Assets
//
//- (void)loadAssets {
//    if (NSClassFromString(@"PHAsset")) {
//        
//        // Check library permissions
//        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//        if (status == PHAuthorizationStatusNotDetermined) {
//            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//                if (status == PHAuthorizationStatusAuthorized) {
//                    [self performLoadAssets];
//                }
//            }];
//        } else if (status == PHAuthorizationStatusAuthorized) {
//            [self performLoadAssets];
//        }
//        
//    } else {
//        
//        // Assets library
//        [self performLoadAssets];
//        
//    }
//}
//
//- (void)performLoadAssets {
//    
//    // Initialise
//    _assets = [NSMutableArray new];
//    
//    // Load
//    if (NSClassFromString(@"PHAsset")) {
//        
//        // Photos library iOS >= 8
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            PHFetchOptions *options = [PHFetchOptions new];
//            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
//            PHFetchResult *fetchResults = [PHAsset fetchAssetsWithOptions:options];
//            [fetchResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                [_assets addObject:obj];
//            }];
//            if (fetchResults.count > 0) {
////                [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//            }
//        });
//        
//    } else {
//        
//        // Assets Library iOS < 8
//        _ALAssetsLibrary = [[PHPhotoLibrary alloc] init];
//        
//        // Run in the background as it takes a while to get all assets from the library
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            
//            NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
//            NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
//            
//            // Process assets
//            void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                if (result != nil) {
//                    NSString *assetType = [result valueForProperty:ALAssetPropertyType];
//                    if ([assetType isEqualToString:ALAssetTypePhoto] || [assetType isEqualToString:ALAssetTypeVideo]) {
//                        [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
//                        NSURL *url = result.defaultRepresentation.url;
//                        [_ALAssetsLibrary assetForURL:url
//                                          resultBlock:^(ALAsset *asset) {
//                                              if (asset) {
//                                                  @synchronized(_assets) {
//                                                      [_assets addObject:asset];
//                                                      if (_assets.count == 1) {
//                                                          // Added first asset so reload data
//                                                          [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//                                                      }
//                                                  }
//                                              }
//                                          }
//                                         failureBlock:^(NSError *error){
//                                             NSLog(@"operation was not successfull!");
//                                         }];
//                        
//                    }
//                }
//            };
//            
//            // Process groups
//            void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
//                if (group != nil) {
//                    [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
//                    [assetGroups addObject:group];
//                }
//            };
//            
//            // Process!
//            [_ALAssetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
//                                            usingBlock:assetGroupEnumerator
//                                          failureBlock:^(NSError *error) {
//                                              NSLog(@"There is an error");
//                                          }];
//            
//        });
//        
//    }
//    
//}


@end
