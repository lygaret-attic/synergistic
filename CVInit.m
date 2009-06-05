//
//  CVInit.m
//  Synergistic
//
//  Created by siteworx on 9/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "ConfigView.h"

@implementation ConfigView (InitMethods)

- (void) initBackgroundGradient
{
    CGFloat red1   =  10.0 / 255.0;
    CGFloat green1 =  10.0 / 255.0;
    CGFloat blue1  =  10.0 / 255.0;
    
    CGFloat red2   =  45.0 / 255.0;
    CGFloat green2 =  45.0 / 255.0;
    CGFloat blue2  =  45.0 / 255.0;
    
    NSColor* gradientTop    = [NSColor colorWithCalibratedRed:red1 green:green1 blue:blue1 alpha:1.0];    
    NSColor* gradientBottom = [NSColor colorWithCalibratedRed:red2 green:green2 blue:blue2 alpha:1.0];
    
    backgroundGradient = [[NSGradient alloc] initWithStartingColor:gradientBottom endingColor:gradientTop];
}

@end
