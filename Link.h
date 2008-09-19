//
//  Link.h
//  Synergistic
//
//  Created by siteworx on 9/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Screen;

@interface Link : NSObject {
    Screen *parent;
    Screen *child;
    LinkDirection direction;
}

@property(retain) Screen *parent;
@property(retain) Screen *child;
@property(assign) LinkDirection direction;

- (id) initWithParent: (Screen *) newParent Child: (Screen *) newChild inDirection: (LinkDirection) newDirection;

@end
