//
//  ConfigView.h
//  Synergistic
//
//  Created by siteworx on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

#import "NSImage-Extras.h";
#import "Screen.h";
#import "Link.h";

@interface ConfigView : NSView 
{
    NSGradient *backgroundGradient;
    CGImageRef screenImage;
    CGImageRef boxImage;
}

@property(retain) NSGradient *backgroundGradient;

- (void) initBackgroundGradient;
- (void) addFirstScreen: (Screen *) screen;
- (void) addScreen: (Screen *) screen toThe: (LinkDirection) direction Of: (NSString *) layerName;
- (void) addBoxToThe: (LinkDirection) direction Of: (NSString *) layerName;

@end
