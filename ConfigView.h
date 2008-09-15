//
//  ConfigView.h
//  Synergistic
//
//  Created by siteworx on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CALayer;
@interface ConfigView : NSView 
{
    NSGradient *backgroundGradient;

    CALayer *screenLayer;
    CALayer *boxLayer;
}

@end
