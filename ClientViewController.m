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

	task = [[ClientTask alloc] initWithName: @"client"];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver: self
		   selector: @selector(taskHasOutput:)
			   name: BTTaskHasOutputNotification
			 object: task];

	[nc addObserver: self
		   selector: @selector(taskTerminated:)
			   name: BTTaskTerminatedNotification
			 object: task];
}

- (IBAction) startStopClient: (id) sender
{	
	if ([task isRunning]) {
		[task stopTask];
	}
	else {
		task.hostname = [hostnameTextField stringValue];
		task.alias	  =	[aliasNameTextField stringValue];
		task.retry	  = [retryCheckbox state];
		[task startTask];

		// clear the log
		[outputTextArea setString: @""];
		[startClientButton setTitle: @"Disconnect"];
	}
}

- (void) taskHasOutput: (NSNotification *) n
{
	NSTextStorage *ts = [outputTextArea textStorage];
	NSString *s = [[n userInfo] valueForKey: BTTaskHasOutputDataItem];
	NSRange endRange = NSMakeRange([ts length], 0);
	
	[ts replaceCharactersInRange: endRange withString: s];
	[outputTextArea scrollRangeToVisible: endRange];
}

- (void) taskTerminated: (NSNotification *) n
{
	[startClientButton setState: 0];
	[startClientButton setTitle: @"Connect"];
}

@end
