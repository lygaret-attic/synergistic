//
//  ConfigView.m
//  Synergistic
//
//  Created by siteworx on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NSImage-Extras.h"
#import "ConfigView.h"

NSPoint NSPointFromCenterOfRectWithOffsets(NSRect rect, int offsetX, int offsetY)
{
    NSPoint p;
    p.x = rect.origin.x + (rect.size.width / 2) + offsetX;
    p.y = rect.origin.y + (rect.size.height / 2) + offsetY;
    return p;
}

@interface ConfigView ()
    @property(retain) NSGradient *backgroundGradient;
    - (void) initBackgroundGradient;
@end

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
    
    NSString *screenFile = [[NSBundle mainBundle] pathForImageResource: @"screen"];
    NSImage *screenImage = [[NSImage alloc] initWithContentsOfFile: screenFile];
    screenLayer          = [CALayer layer];
    screenLayer.name     = @"screen";
    screenLayer.bounds   = CGRectMake(0, 0, 64, 64);
    screenLayer.position = NSPointToCGPoint(NSPointFromCenterOfRectWithOffsets(self.bounds, 0, 0));
    screenLayer.delegate = self;
    screenLayer.contents = (id)[screenImage cgImage];
    screenLayer.contentsGravity     = kCAGravityResizeAspect;
    
    NSString *boxFile = [[NSBundle mainBundle] pathForImageResource: @"screen_box"];
    NSImage *boxImage = [[NSImage alloc] initWithContentsOfFile: boxFile];
    boxLayer          = [CALayer layer];
    boxLayer.name     = @"box";
    boxLayer.bounds   = CGRectMake(0, 0, 48, 48);
    boxLayer.position = NSPointToCGPoint(NSPointFromCenterOfRectWithOffsets(self.bounds, 0, 64));
    boxLayer.delegate = self;
    boxLayer.contents = (id)[boxImage cgImage];
    boxLayer.contentsGravity = kCAGravityResizeAspect;

    [self.layer addSublayer: screenLayer];
    [self.layer addSublayer: boxLayer];
    
    CALayer *boxLayer2 = [CALayer layer];
    boxLayer2.name     = @"box";
    boxLayer2.bounds   = CGRectMake(0, 0, 48, 48);
    boxLayer2.position = NSPointToCGPoint(NSPointFromCenterOfRectWithOffsets(self.bounds, 0, -64));
    boxLayer2.delegate = self;
    boxLayer2.contents = (id)[boxImage cgImage];
    boxLayer2.contentsGravity = kCAGravityResizeAspect;
    [self.layer addSublayer: boxLayer2];

    CALayer *boxLayer3 = [CALayer layer];
    boxLayer3.name     = @"box";
    boxLayer3.bounds   = CGRectMake(0, 0, 48, 48);
    boxLayer3.position = NSPointToCGPoint(NSPointFromCenterOfRectWithOffsets(self.bounds, 72, 0));
    boxLayer3.delegate = self;
    boxLayer3.contents = (id)[boxImage cgImage];
    boxLayer3.contentsGravity = kCAGravityResizeAspect;
    [self.layer addSublayer: boxLayer3];

    CALayer *boxLayer4 = [CALayer layer];
    boxLayer4.name     = @"box";
    boxLayer4.bounds   = CGRectMake(0, 0, 48, 48);
    boxLayer4.position = NSPointToCGPoint(NSPointFromCenterOfRectWithOffsets(self.bounds, -72, 0));
    boxLayer4.delegate = self;
    boxLayer4.contents = (id)[boxImage cgImage];
    boxLayer4.contentsGravity = kCAGravityResizeAspect;
    [self.layer addSublayer: boxLayer4];
    
    [self.layer setNeedsDisplay];
}

- (void)drawRect:(NSRect)rect {
    [self.backgroundGradient drawInRect: [self bounds] angle: 90.0];
}

- (void) mouseDown: (NSEvent*)theEvent
{
    NSPoint mousePointInView = [self convertPoint:theEvent.locationInWindow fromView:nil];
    CGPoint cgMousePointInView = NSPointToCGPoint(mousePointInView);
    [CATransaction begin];
    [CATransaction setValue: [NSNumber numberWithFloat: 0.1]
                     forKey: kCATransactionAnimationDuration];
    
    [screenLayer removeAllAnimations];
    screenLayer.position = cgMousePointInView;
    [CATransaction commit];    
}

- (void) mouseDragged:(NSEvent*)theEvent
{
    NSPoint mousePointInView = [self convertPoint:theEvent.locationInWindow fromView:nil];
    CGPoint cgMousePointInView = NSPointToCGPoint(mousePointInView);
    [CATransaction begin];
        [CATransaction setValue: [NSNumber numberWithFloat:0.05]
                         forKey: kCATransactionAnimationDuration];
    
        [screenLayer removeAllAnimations];
        screenLayer.position = cgMousePointInView;
    [CATransaction commit];
}

#pragma mark Misc Drawing Related Methods

- (void) initBackgroundGradient
{
    CGFloat red1   =  163.0 / 255.0;
    CGFloat green1 =  163.0 / 255.0;
    CGFloat blue1  =  163.0 / 255.0;
    
    CGFloat red2   =  116.0 / 255.0;
    CGFloat green2 =  116.0 / 255.0;
    CGFloat blue2  =  116.0 / 255.0;
    
    NSColor* gradientTop    = [NSColor colorWithCalibratedRed:red1 green:green1 blue:blue1 alpha:1.0];    
    NSColor* gradientBottom = [NSColor colorWithCalibratedRed:red2 green:green2 blue:blue2 alpha:1.0];
    
    self.backgroundGradient = [[NSGradient alloc] initWithStartingColor:gradientBottom endingColor:gradientTop];
}

@end
