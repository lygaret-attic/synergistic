//
//  ClientTask.m
//  Synergistic
//
//  Created by siteworx on 9/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ClientTask.h"

@implementation ClientTask

- (void) connectToServer: (NSString *) hostName 
{
	task = [[NSTask alloc] init];
	outPipe = [NSPipe pipe];
	outHandle = [outPipe fileHandleForReading];

	[task setLaunchPath: [self execPath]];
	[task setArguments: [NSArray arrayWithObjects: hostName, nil]];
//	[task setStandardOutput: outPipe];
//	[task setStandardError: outPipe];
	[task launch];
	
//	NSData *outData = [outHandle readDataToEndOfFile];
//	[task waitUntilExit];
//	[task release];
	
//	NSLog(@"%@", outData);
}

- (void) terminate
{
	[task terminate];
	[task waitUntilExit];
}

- (NSString *) execPath
{
	NSBundle *bundle = [NSBundle mainBundle];
	return [[bundle pathForAuxiliaryExecutable: @"synergyc"] autorelease];
}

@end
