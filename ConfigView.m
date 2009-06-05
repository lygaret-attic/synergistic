//
//  ConfigView.m
//  Synergistic
//
//  Created by siteworx on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ConfigView.h"
#import "ScreenLayer.h"
#import "Configuration.h"

@implementation ConfigView

- (void) dealloc
{
    [config release];
    [backgroundGradient release];

    [super dealloc];
}

- (void) awakeFromNib
{
    // initialization
    [self initBackgroundGradient];

    CALayer *rootLayer = [[CALayer layer] retain];
    rootLayer.bounds = NSRectToCGRect(self.bounds);
    rootLayer.name = @"container";
    rootLayer.backgroundColor = CGColorCreateGenericGray(0.1, 1.0);
    rootLayer.layoutManager = [CAConstraintLayoutManager layoutManager];
    
    // set up layer info
    [self setLayer: rootLayer];
    [self setWantsLayer: YES];

    config = [[Configuration alloc] init];
    selectedLayer = nil;
    
    // draw the initial blank box
    Screen *s = [[Screen alloc] initWithName: @"zoidberg"];
    CALayer *box = [[ScreenLayer alloc] initWithScreen: s];
    
    [box addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidX relativeTo: @"superlayer" attribute: kCAConstraintMidX]];
    [box addConstraint: [CAConstraint constraintWithAttribute: kCAConstraintMidY relativeTo: @"superlayer" attribute: kCAConstraintMidY]];
    [self.layer addSublayer: box];
}

- (void)mouseDown:(NSEvent *)theEvent {

    NSPoint convertedPoint = [self convertPoint: [theEvent locationInWindow] fromView: nil];
    SelectableLayer *hitLayer = (SelectableLayer *)[self.layer hitTest: NSPointToCGPoint(convertedPoint)];
    
    if (hitLayer && hitLayer != self.layer) {
        if (hitLayer != selectedLayer) {
            selectedLayer.selected = NO;
            
            selectedLayer = hitLayer;
            selectedLayer.selected = YES;
            [selectedLayer setNeedsDisplay];
        }
    }    
    else {
        selectedLayer.selected = NO;
        [selectedLayer setNeedsDisplay];
        selectedLayer = nil;
    }
}

- (void)drawRect:(NSRect)rect {
}

@end
