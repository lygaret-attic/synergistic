//
//  ScreenLayer.m
//  Synergistic
//
//  Created by siteworx on 9/24/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ScreenLayer.h"
#import "NSImage-Extras.h"
#import "Screen.h"

#define IMAGE_WIDTH 32
#define IMAGE_HEIGHT 32
#define TEXT_OFFSET 20

@implementation ScreenLayer

- (id) initWithScreen: (Screen *) screen
{
    if (self = [super init])
    {
        backingScreen = screen;

        // get the image to display
        NSString *imagePath = [[NSBundle mainBundle] pathForImageResource: @"screen"];
        NSImage *image = [[NSImage alloc] initWithContentsOfFile: imagePath];
        CGImageRef screenImage = CGImageRetain([image cgImage]);
        [image release];
        
        // initialize thyself
        self.layoutManager = [CAConstraintLayoutManager layoutManager];
        self.name = screen.name;
        self.selected = NO;
        
        CALayer *imagelayer = [[CALayer layer] retain];
        imagelayer.name = @"image";
        imagelayer.bounds = CGRectMake(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
        imagelayer.contents = (id) screenImage;
        
        CATextLayer *text = [[CATextLayer layer] retain];
        text.name = @"name";
        text.string = screen.name;
        text.font = @"LucidaGrande-Bold";
        text.fontSize = 11.0;
        text.foregroundColor = CGColorCreateGenericGray(0.8, 0.9);
        text.alignmentMode = kCAAlignmentCenter;
        
        // height of the layer is height of the img + 16 + height of text (auto)
        float width = 14.0 + ((text.bounds.size.width > IMAGE_WIDTH) ? text.bounds.size.width : IMAGE_WIDTH);
        float height = 14.0 + IMAGE_HEIGHT + TEXT_OFFSET + text.bounds.size.height;
        float size = width > height ? width : height;
        
        self.bounds = CGRectMake(0, 0, size, size);
        
        [imagelayer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"superlayer" attribute: kCAConstraintMidX]];
        [imagelayer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMaxY relativeTo: @"superlayer" attribute: kCAConstraintMaxY offset: -7.0]];
        
        [text addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"superlayer" attribute: kCAConstraintMidX]];
        [text addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMinY relativeTo: @"superlayer" attribute: kCAConstraintMinY offset: 7.0]];
        
        [self addSublayer: imagelayer];
        [self addSublayer: text];
    }
    
    return self;
}

@end
