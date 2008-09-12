//
//  BackgroundTask.m
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
//  Created by Jon Raphaelson on 9/10/08.
//  Copyright 2008 Jon Raphaelson. All rights reserved.
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
	
	if (task) {
        [task interrupt];
        [task waitUntilExit];
        [task release];   
    }

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
    
    [nc addObserver: self 
           selector: @selector(appShuttingDown:) 
               name: NSApplicationWillTerminateNotification 
             object: [NSApplication sharedApplication]];
	
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

- (void) appShuttingDown: (NSNotification *) n
{
    if (task) {
        [task interrupt];
        [task waitUntilExit];        
    }
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
