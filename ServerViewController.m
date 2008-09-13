//
//  ServerViewController.m
//  Synergistic
//
//  Created by siteworx on 9/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ServerViewController.h"
#import "Configuration.h"
#import "Screen.h"

@implementation ServerViewController
@synthesize configuration;

- (id) init
{
    if (self = [super init]) {
        configuration = [Configuration sampleConfiguration];
    }
    
    return self;
}

- (void) awakeFromNib
{
    int i, j;
    NSMutableArray *screens = configuration.screens;

    for (i = 0; i < [screens count]; i++)
    {
        Screen *s = [screens objectAtIndex: i];
        NSLog(@"screen: %@\n", s.name);
        
        NSMutableArray *aliases = s.aliases;
        for (j = 0; j < [aliases count]; j++)
        {
            NSLog(@"aliased with: %@", [aliases objectAtIndex: j]);
        }
        
        NSLog(@"\n\n");
    }
}

- (void) dealloc
{
    [configuration release];
    [super dealloc];
}

@end
