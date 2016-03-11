//
//  UIStoryboard+Utility.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/11/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "UIStoryboard+Utility.h"

@implementation UIStoryboard (Utility)


+ (UIViewController *)instantiateViewControllerWithStoryboardName:(NSString *)name screenStoryboardId:(NSString *)screenId {

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
    
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:screenId];
    
    return vc;
}
@end
