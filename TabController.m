//
//  TabController.m
//  Synergistic
//
//  Created by siteworx on 9/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "TabController.h"

@implementation TabController

- (void) awakeFromNib
{
	clientSize = [clientView frame].size;
	serverSize = [serverView frame].size;
	optionsSize = [optionsView frame].size;
	
	[self switchToView: clientView sized: clientSize animate: NO];
}

- (IBAction) switchToClientView: (id) sender
{
	[tabView selectTabViewItemAtIndex: 0];
}

- (IBAction) switchToServerView: (id) sender
{
	[tabView selectTabViewItemAtIndex: 1];
}

- (IBAction) switchToOptionsView: (id) sender;
{
	[tabView selectTabViewItemAtIndex: 2];
}

- (void) tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
	NSString *id = [tabViewItem identifier];
	NSView *view;
	NSSize size;
	
	if ([id isEqualToString: @"client"]) {
		view = clientView;
		size = clientSize;
	}
	else if ([id isEqualToString: @"server"]) {
		view = serverView;
		size = serverSize;
	}
	else {
		view = optionsView;
		size = optionsSize;
	}
	
	[self switchToView: view sized: size animate: YES];
}

- (void) switchToView: (NSView *) view sized: (NSSize) size animate: (BOOL) animate
{
	NSRect aFrame;
	float newWidth = size.width;
	float newHeight = size.height + 24; // status bar = 16px
	
	aFrame = [window contentRectForFrameRect: [window frame]];
	aFrame.origin.y += aFrame.size.height;
	aFrame.origin.y -= newHeight;
	aFrame.size.height = newHeight;
	aFrame.size.width = newWidth;

	aFrame = [window frameRectForContentRect: aFrame];
	
	[[tabView selectedTabViewItem] setView: view];
	[window setFrame: aFrame display: YES animate: animate];
}

@end
