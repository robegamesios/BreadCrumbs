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

@end
