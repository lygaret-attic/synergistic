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
}

- (void) dealloc
{
    [configuration release];
    [super dealloc];
}

@end
