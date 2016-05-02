//
//  MapAnnotationView.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 4/8/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "MapAnnotationView.h"
#import "MapAnnotation.h"

static NSString * const kMapAnnotationViewKey = @"MapAnnotationView";

@interface MapAnnotationView ()

@property (strong, nonatomic) UIView *customBubbleCalloutView;

@end

@implementation MapAnnotationView


- (id)initWithAnnotation:(MapAnnotation *)annotation reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self != nil) {
        self.customBubbleCalloutView = [[[NSBundle mainBundle] loadNibNamed:kMapAnnotationViewKey owner:self options:nil] firstObject];
        
        self.customBubbleCalloutView.hidden = YES;
        
        self.customBubbleCalloutView.center = CGPointMake(0, -self.customBubbleCalloutView.frame.size.height/2);
        
        [self addSubview:self.customBubbleCalloutView];

    }
    return self;
}


#pragma mark - Override Methods

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if(selected) {
        if (self.AnnotationSelectedBlock) {
            self.customBubbleCalloutView.hidden = NO;
            self.AnnotationSelectedBlock();
        }
        
    } else {
        self.customBubbleCalloutView.hidden = YES;
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView != nil)
    {
        [self.superview bringSubviewToFront:self];
    }
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect rect = self.bounds;
    BOOL isInside = CGRectContainsPoint(rect, point);
    if(!isInside)
    {
        for (UIView *view in self.subviews)
        {
            isInside = CGRectContainsPoint(view.frame, point);
            if(isInside)
                break;
        }
    }
    return isInside;
}


#pragma mark - IBActions

- (IBAction)addButtonTapped:(UIButton *)sender {
    NSLog(@"addButton tapped");
}


- (IBAction)callButtonTapped:(UIButton *)sender {
    NSLog(@"callButton tapped");
}

- (IBAction)moreInfoButtonTapped:(UIButton *)sender {
    NSLog(@"moreInfoButton tapped");
}
@end
