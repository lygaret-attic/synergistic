//
//  SelectableLayer.h
//  Synergistic
//
//  Created by siteworx on 9/24/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface SelectableLayer : CALayer {
    BOOL selected;
}

@property(assign) BOOL selected;

@end
