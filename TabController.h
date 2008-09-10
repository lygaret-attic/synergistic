//
//  TabController.h
//  Synergistic
//
//  Created by siteworx on 9/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TabController : NSObject {
	IBOutlet NSTabView *tabView;
	IBOutlet NSWindow *window;
	
	IBOutlet NSView *clientView;
	IBOutlet NSView *serverView;
	IBOutlet NSView *logView;
	
	NSSize clientSize;
	NSSize serverSize;
	NSSize logSize;
}

- (IBAction) switchToClientView: (id) sender;
- (IBAction) switchToServerView: (id) sender;
- (IBAction) switchToLogView: (id) sender;

- (void) switchToView: (NSView *) view sized: (NSSize) size animate: (BOOL) animate;

@end
