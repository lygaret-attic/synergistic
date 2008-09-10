//
//  ClientTask.m
//  Synergistic
//
//  Created by siteworx on 9/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
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
	
	if (self.alias) {
		[argList addObject: @"-n"];
		[argList addObject: self.alias];
	}
	
	if (!self.retry)
		[argList addObject: @"-1"];
	
	
	if (self.hostname) 
		[argList addObject: self.hostname];
	
	return argList;
}

@end
