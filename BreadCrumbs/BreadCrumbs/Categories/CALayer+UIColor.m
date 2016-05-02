//
//  CALayer+UIColor.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 4/17/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "CALayer+UIColor.h"

@implementation CALayer (UIColor)

- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor: self.borderColor];
}
@end
