//
//  BackgroundTask.m
//  Synergistic
//
//  Created by siteworx on 9/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BackgroundTask.h"

@implementation BackgroundTask

- (NSString *) launchPath { [NSException raise:@"Abstract Class Exception" format:@"Error, must override -launchPath!."]; return nil; }
- (NSArray *) launchArgs { [NSException raise:@"Abstract Class Exception" format:@"Error, must override -launchPath!."]; return nil; }

- (id) initWithName: (NSString *) _name
{
	if (self = [super init]) {
		name = [_name retain];	
	}
	
	return self;
}

- (void) dealloc
{
	[name release];
	
	if (task) [task release];
	if (pipe) [pipe release];
	
	[super dealloc];
}

- (void) startTask 
{
	if (task)
		return;
	
	if (pipe)
		[pipe release];
	
	pipe = [[NSPipe alloc] init];
	task = [[NSTask alloc] init];
	[task setLaunchPath: [self launchPath]];
	[task setArguments: [self launchArgs]];
	[task setStandardOutput: pipe];
	[task setStandardError: pipe];
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc removeObserver: self];
	
	[nc addObserver: self
		   selector: @selector(dataReady:) 
			   name: NSFileHandleReadCompletionNotification 
			 object: [pipe fileHandleForReading]];
	
	[nc addObserver: self
		   selector: @selector(taskTerminated:)
			   name: NSTaskDidTerminateNotification
			 object: task];
	
	[nc postNotificationName: BTTaskStartedNotification object: self];
	
	[task launch];
	[[pipe fileHandleForReading] readInBackgroundAndNotify];
}

- (void) stopTask
{
	[task interrupt];
}

- (bool) isRunning
{
	return (task != nil);
}

- (void) dataReady: (NSNotification *) n
{
	NSData *d = [[n userInfo] valueForKey: NSFileHandleNotificationDataItem];
	if ([d length]) 
	{
		NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		NSString *s = [[NSString alloc] initWithData: d encoding: NSUTF8StringEncoding];
		NSDictionary *info = [NSDictionary dictionaryWithObject: s forKey: BTTaskHasOutputDataItem];
		
		[nc postNotificationName: BTTaskHasOutputNotification
						  object: self
						userInfo: info];

		[s release];
	}
	
		
	// if there is a task still, keep reading
	if (task)
		[[pipe fileHandleForReading] readInBackgroundAndNotify];
}

- (void) taskTerminated: (NSNotification *) n
{
	[task release];
	task = nil;

	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc postNotificationName: BTTaskTerminatedNotification object: self];
}

@end
