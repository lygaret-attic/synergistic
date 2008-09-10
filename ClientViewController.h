//
//  ClientViewController.h
//  Synergistic
//
//  Created by siteworx on 9/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ClientTask.h"

@interface ClientViewController : NSObject {
	IBOutlet NSTextField	*hostnameTextField;
	IBOutlet NSTextField	*aliasNameTextField;
	IBOutlet NSButton		*retryCheckbox;
	IBOutlet NSTextView		*outputTextArea;
	IBOutlet NSButton		*startClientButton;

	NSTask *task;
	NSPipe *pipe;
}

- (IBAction) startStopClient: (id) sender;

@end
