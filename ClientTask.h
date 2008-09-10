//
//  ClientTask.h
//  Synergistic
//
//  Created by siteworx on 9/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BackgroundTask.h"

@interface ClientTask : BackgroundTask
{
	NSString *alias;
	NSString *hostname;
	BOOL retry;
}

@property(retain) NSString *alias;
@property(retain) NSString *hostname;
@property BOOL retry;

@end
