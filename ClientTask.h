//
//  ClientTask.h
//  Synergistic
//
//  Created by siteworx on 9/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ClientTask : NSObject {
	NSTask *task;

	NSPipe *outPipe;
	NSFileHandle *outHandle;
}

+ (void) connectToServer: (NSString *) hostName;

@end
