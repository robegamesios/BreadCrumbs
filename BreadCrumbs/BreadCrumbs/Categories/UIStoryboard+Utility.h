//
//  UIStoryboard+Utility.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/11/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Utility)

+ (UIViewController *)instantiateViewControllerWithStoryboardName:(NSString *)name screenStoryboardId:(NSString *)screenId;

@end
