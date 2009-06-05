//
//  ServerViewController.m
//  Synergistic
//
//  Created by siteworx on 9/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "UIGlobals.h"
#import "ServerViewController.h"
#import "Configuration.h"

@implementation ServerViewController
@synthesize configuration;

- (id) init
{
    if (self = [super init]) {
        configuration = [[Configuration sampleConfiguration] retain];    
    }
    
    return self;
}

- (void) dealloc
{
    [configuration release];
    [super dealloc];
}

- (void) awakeFromNib
{
    [screenTable setDelegate: self];
    [screenTable setDataSource: self];
    [screenTable registerForDraggedTypes: [NSArray arrayWithObject: ScreenDragType]];
}

- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: rowIndexes];
    [pboard declareTypes: [NSArray arrayWithObject: ScreenDragType] owner: self];
    [pboard setData: data forType: ScreenDragType];
    return YES;
}

@end
