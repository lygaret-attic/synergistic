//
//  ConfigView.m
//  Synergistic
//
//  Created by siteworx on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ConfigView.h"
#import "Configuration.h"

@implementation ConfigView

@synthesize backgroundGradient;

- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) 
    {
        [self initBackgroundGradient];
    }
    
    return self;
}

- (void) awakeFromNib
{
    self.wantsLayer = YES;
    self.layer.bounds = NSRectToCGRect(self.bounds);
    self.layer.name = @"container";
    self.layer.layoutManager = [CAConstraintLayoutManager layoutManager];
    
    NSString *screenFile = [[NSBundle mainBundle] pathForImageResource: @"screen"];
    screenImage = [[[NSImage alloc] initWithContentsOfFile: screenFile] cgImage];

    NSString *boxFile = [[NSBundle mainBundle] pathForImageResource: @"screen_box"];
    boxImage = [[[NSImage alloc] initWithContentsOfFile: boxFile] cgImage];

    [self addFirstScreen: nil];
    
/*    Configuration *config = [Configuration sampleConfiguration];
    for (Screen *screen in config.screens)
    {
        [self addScreen: screen toThe: Left Of: @"first"];
    }
*/    
    // TODO: Fix this!
    [self addFirstScreen: nil];
    [self addScreen: nil toThe: Left Of: @"first"];
    [self addScreen: nil toThe: Below Of: @"first"];
    [self addBoxToThe: Above Of: @"first"];
    [self addBoxToThe: Right Of: @"first"];
}

- (void) addFirstScreen: (Screen *) screen
{
    CATextLayer *screenLayer = [[CATextLayer layer] retain];
    screenLayer.bounds = CGRectMake(0, 0, 64, 64);
    screenLayer.delegate = self;
    //screenLayer.contents = (id) screenImage;
    screenLayer.string = @"Hello!";
    screenLayer.name = @"first";
    
    [screenLayer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"superlayer" attribute: kCAConstraintMidX]];
    [screenLayer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidY relativeTo: @"superlayer" attribute: kCAConstraintMidY]];
        
    [self.layer addSublayer: screenLayer];
    [self.layer setNeedsDisplay];
}

- (void) addScreen:(Screen *)screen toThe:(LinkDirection)direction Of:(NSString *)layerName
{
    CALayer *screenLayer = [[CALayer layer] retain];
    screenLayer.layoutManager = [CAConstraintLayoutManager layoutManager];
    
    CALayer *image = [CALayer layer];
    image.bounds = CGRectMake(0, 0, 64, 64);
    image.contents = (id) screenImage;
    image.name = @"image";

    CATextLayer *name = [CATextLayer layer];
    name.string = layerName;
    name.name = @"name";
    name.foregroundColor = (CGColorRef) kCGColorBlack;
    
    [name addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"image" attribute: kCAConstraintMidX]];
    [name addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMaxY relativeTo: @"image" attribute: kCAConstraintMinY offset: -8.0]];
    
    [screenLayer addSublayer: image];
    [screenLayer addSublayer: name];
    
    [self addConstraintsToLayer: screenLayer Direction: direction ofLayerNamed: layerName];
    
    [self.layer addSublayer: screenLayer];
    [self.layer setNeedsDisplay];
}

- (void) addBoxToThe: (LinkDirection) direction Of: (NSString *) layerName
{
    CALayer *boxLayer = [[CALayer layer] retain];
    boxLayer.bounds   = CGRectMake(0, 0, 48, 48);
    boxLayer.delegate = self;
    boxLayer.contents = (id) boxImage;

    [self addConstraintsToLayer: boxLayer Direction: direction ofLayerNamed: layerName];
    
    [self.layer addSublayer: boxLayer];
    [self.layer setNeedsDisplay];
}

- (void) addConstraintsToLayer: (CALayer *) layer Direction: (LinkDirection) direction ofLayerNamed: (NSString *) layerName
{
    switch (direction)
    {
        case Left:
            [layer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMaxX relativeTo: layerName attribute: kCAConstraintMinX offset: -32.0]];
            [layer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidY relativeTo: layerName attribute: kCAConstraintMidY]];
            break;
            
        case Right:
            [layer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMinX relativeTo: layerName attribute: kCAConstraintMaxX offset: 32.0]];
            [layer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidY relativeTo: layerName attribute: kCAConstraintMidY]];
            break;
            
        case Above:
            [layer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMinY relativeTo: layerName attribute: kCAConstraintMaxY offset: 16.0]];
            [layer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: layerName attribute: kCAConstraintMidX]];
            break;
            
        case Below:
            [layer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMaxY relativeTo: layerName attribute: kCAConstraintMinY offset: -16.0]];
            [layer addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: layerName attribute: kCAConstraintMidX]];
            break;
    }
}

- (void)drawRect:(NSRect)rect {
    [self.backgroundGradient drawInRect: [self bounds] angle: 90.0];
    
    [[NSColor darkGrayColor] setFill];
    NSFrameRect(self.bounds);
}

#pragma mark Misc Drawing Related Methods

- (void) initBackgroundGradient
{
    CGFloat red1   =  210.0 / 255.0;
    CGFloat green1 =  210.0 / 255.0;
    CGFloat blue1  =  210.0 / 255.0;
    
    CGFloat red2   =  225.0 / 255.0;
    CGFloat green2 =  225.0 / 255.0;
    CGFloat blue2  =  255.0 / 255.0;
    
    NSColor* gradientTop    = [NSColor colorWithCalibratedRed:red1 green:green1 blue:blue1 alpha:1.0];    
    NSColor* gradientBottom = [NSColor colorWithCalibratedRed:red2 green:green2 blue:blue2 alpha:1.0];
    
    self.backgroundGradient = [[NSGradient alloc] initWithStartingColor:gradientBottom endingColor:gradientTop];
}

@end
