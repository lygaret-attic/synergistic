//
//  ClientTask.m
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

#import "ClientTask.h"


@implementation ClientTask
@synthesize hostname, alias, retry;

- (id) initWithName: (NSString *) _name
{
	if (self = [super initWithName: _name])
	{
		self.hostname = nil;
		self.alias = nil;
		self.retry = YES;
	}
	
	return self;
}

- (void) dealloc
{
    [hostname release];
    [alias release];
    [super dealloc];
}

- (NSString *) launchPath
{
	NSBundle *mainBundle = [NSBundle mainBundle];
	return [mainBundle pathForResource: @"synergyc" ofType: @""];
}

- (NSArray *) launchArgs
{
	NSMutableArray *argList = [NSMutableArray array];
	[argList addObject: @"-f"];
	[argList addObject: @"-d"];
	[argList addObject: @"NOTE"];
	
	if (self.alias && [self.alias length] > 0) {
		[argList addObject: @"-n"];
		[argList addObject: self.alias];
	}
	
	if (!self.retry)
		[argList addObject: @"-1"];
	
	
	if (self.hostname && [self.hostname length] > 0) 
		[argList addObject: self.hostname];
	
	return argList;
}

@end
