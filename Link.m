//
//  Link.m
//  Synergistic
//
//  Created by siteworx on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Link.h"
#import "Screen.h"

@implementation Link
@synthesize parent, child, direction;

- (id) initWithParent: (Screen *) newParent Child: (Screen *) newChild inDirection: (LinkDirection) newDirection
{
    if (self = [super init])
    {
        parent  = [newParent retain];
        child   = [newChild retain];
        direction = newDirection;
    }
    
    return self;
}

- (void) dealloc
{
    [parent release];
    [child release];
    [super dealloc];
}
@end
