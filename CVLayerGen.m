//
//  CVLayerGen.m
//  Synergistic
//
//  Created by siteworx on 9/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ConfigView.h"
#import "Screen.h"

#define IMAGE_HEIGHT 32
#define IMAGE_WIDTH 32
#define TEXT_OFFSET 18

@implementation ConfigView (LayerGen)

- (CALayer *) makeLayerForScreen: (Screen *) screen
{    
    CALayer *layer = [[CALayer layer] retain];
    layer.layoutManager = [CAConstraintLayoutManager layoutManager];
    layer.name = screen.name;
    
    layer.backgroundColor = CGColorCreateGenericGray(0.2, 0.3);
    layer.borderColor = CGColorCreateGenericGray(0.3, 0.3);
    layer.cornerRadius = 2.0;
    layer.borderWidth = 1.0;

    CALayer *image = [[CALayer layer] retain];
    image.name = @"image";
    image.bounds = CGRectMake(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
    image.contents = (id) screenImage;
    
    CATextLayer *text = [[CATextLayer layer] retain];
    text.name = @"name";
    text.string = screen.name;
    text.font = @"LucidaGrande-Bold";
    text.fontSize = 12.0;
    text.foregroundColor = CGColorCreateGenericGray(0.8, 0.9);
    text.alignmentMode = kCAAlignmentCenter;
    
    // height of the layer is height of the img + 16 + height of text (auto)
    float width = 20.0 + ((text.bounds.size.width > IMAGE_WIDTH) ? text.bounds.size.width : IMAGE_WIDTH);
    float height = 20.0 + IMAGE_HEIGHT + TEXT_OFFSET + text.bounds.size.height;
    float size = width > height ? width : height;
    
    layer.bounds = CGRectMake(0, 0, size, size);
    
    [image addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"superlayer" attribute: kCAConstraintMidX]];
    [image addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMaxY relativeTo: @"superlayer" attribute: kCAConstraintMaxY offset: -10.0]];

    [text addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"superlayer" attribute: kCAConstraintMidX]];
    [text addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMinY relativeTo: @"superlayer" attribute: kCAConstraintMinY offset: 10.0]];
    
    [layer addSublayer: image];
    [layer addSublayer: text];
    [layer setNeedsDisplay];
    
    return layer;
}

- (CALayer *) boxLayer
{
    return nil;
}

@end
