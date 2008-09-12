//
//  ClientViewController.m
//  Synergistic
//
//  Synergistic is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//  Created by Jon Raphaelson on 9/9/08.
//  Copyright Jon Raphaelson 2008. All rights reserved.
//

#import "ClientViewController.h"

@implementation ClientViewController
@synthesize task;

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

- (void) dealloc
{
    [task release];
    [super dealloc];
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
