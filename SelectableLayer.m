//
//  SelectableLayer.m
//  Synergistic
//
//  Created by siteworx on 9/24/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SelectableLayer.h"


@implementation SelectableLayer
@synthesize selected;

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.speed = 0.3;
    }
    return self;
}


- (void)display
{
    if (self.selected)
    {        
        self.backgroundColor = CGColorCreateGenericGray(0.2, 0.3);
        self.borderColor = CGColorCreateGenericGray(0.4, 0.4);
        self.cornerRadius = 2.0;
        self.borderWidth = 1.0;
    }    
    else 
    {
        self.backgroundColor = nil;
        self.borderColor = nil;
        self.cornerRadius = 0.0;
        self.borderWidth = 0.0;
    }    
}

/* selecting the children of a selectable layer is the same as
   the selectable layer itself. */
- (CALayer *)hitTest:(CGPoint)thePoint
{
    CALayer *test = [super hitTest: thePoint];
    if (test != nil)
        test = self;
    
    return test;
}

@end
