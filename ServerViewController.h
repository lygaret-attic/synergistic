//
//  ServerViewController.h
//  Synergistic
//
//  Created by siteworx on 9/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Configuration;

@interface ServerViewController : NSObject 
{
    Configuration *configuration;
}

@property(readonly) Configuration *configuration;

@end
