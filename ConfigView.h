//
//  ConfigView.h
//  Synergistic
//
//  Created by siteworx on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "SelectableLayer.h"
#import "NSImage-Extras.h"
#import "Configuration.h"
#import "Screen.h"

#define IMAGE_HEIGHT 32
#define IMAGE_WIDTH 32
#define TEXT_OFFSET 18

@interface ConfigView : NSView 
{
    Configuration *config;
    
@private
    SelectableLayer *selectedLayer;
    NSGradient *backgroundGradient;
}

@end

// CVInit.m
@interface ConfigView (InitMethods)
-(void) initBackgroundGradient;
@end