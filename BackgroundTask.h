//
//  BackgroundTask.h
//  Synergistic
//
//  Created by siteworx on 9/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

APPKIT_EXTERN NSString *BTTaskStartedNotification;
APPKIT_EXTERN NSString *BTTaskTerminatedNotification;
APPKIT_EXTERN NSString *BTTaskHasOutputNotification;
APPKIT_EXTERN NSString *BTTaskHasOutputDataItem;

@interface BackgroundTask : NSObject {
	NSString *name;
	NSTask *task;
	NSPipe *pipe;
}

- (id) initWithName: (NSString *) name;

- (bool) isRunning;
- (void) startTask;
- (void) stopTask;

- (NSString *) launchPath;
- (NSArray *) launchArgs;

@end
