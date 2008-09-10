//
//  ClientViewController.m
//  Synergistic
//
//  Created by siteworx on 9/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ClientViewController.h"

@implementation ClientViewController

- (void) awakeFromNib
{
	[startClientButton setState: 0];
}

- (IBAction) startStopClient: (id) sender
{
	if (task)
		[task interrupt];
	else 
	{
		NSMutableArray *args = [[NSMutableArray alloc] init];
		[args addObject: @"-f"];
		[args addObject: @"-d"];
		[args addObject: @"DEBUG2"];

		if (![retryCheckbox state]) {
			[args addObject: @"-1"];
		}
		
		if ([[aliasNameTextField stringValue] length]) {
			[args addObject: @"-n"];
			[args addObject: [aliasNameTextField stringValue]];
		}
		
		[args addObject: [hostnameTextField stringValue]];
		
		pipe = [[NSPipe alloc] init];
		task = [[NSTask alloc] init];
		[task setLaunchPath: [[NSBundle mainBundle] pathForAuxiliaryExecutable: @"synergyc"]];
		[task setArguments: args];
		[task setStandardOutput: pipe];
		[task setStandardError: pipe];
		
		NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		[nc removeObserver: self];
		
		// recieve events for data at the pipe
		[nc addObserver: self 
			   selector: @selector(dataReady:)
				   name: NSFileHandleReadCompletionNotification
				 object: [pipe fileHandleForReading]];
		
		// receive events for the task terminating
		[nc addObserver: self
			   selector: @selector(taskTerminated:)
				   name: NSTaskDidTerminateNotification
				 object: task];
		
		// clear the log
		[outputTextArea setString: @""];
		[startClientButton setTitle: @"Disconnect"];
		
		[task launch];
		[[pipe fileHandleForReading] readInBackgroundAndNotify];
	}
}

- (void) appendDataToLog: (NSData *) d
{
	NSTextStorage *ts = [outputTextArea textStorage];
	NSString *s = [[NSString alloc] initWithData: d
										encoding: NSUTF8StringEncoding];

	NSRange endRange = NSMakeRange([ts length], 0);
	[ts replaceCharactersInRange: endRange withString: s];
	[outputTextArea scrollRangeToVisible: endRange];
	
	[s release];
}

- (void) dataReady: (NSNotification *) n
{
	NSData *d = [[n userInfo] valueForKey: NSFileHandleNotificationDataItem];

	// if there was data to log, do it
	if ([d length])
		[self appendDataToLog: d];
	
	// if there is a task still, keep reading
	if (task)
		[[pipe fileHandleForReading] readInBackgroundAndNotify];
}

/*- (void) dealloc {
	[pipe release];
	[task terminate];
}*/

- (void) taskTerminated: (NSNotification *) n
{
	[task release];
	task = nil;
	
	[startClientButton setState: 0];
	[startClientButton setTitle: @"Connect"];
}

@end
