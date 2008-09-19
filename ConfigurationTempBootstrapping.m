//
//  ConfigurationTempBootstrapping.m
//  Synergistic
//
//  Created by siteworx on 9/17/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Configuration.h"
#import "Screen.h"

@implementation Configuration (TemporaryBootstrapping)

+ (Configuration *) sampleConfiguration
{
    Screen *win = [[Screen alloc] initWithName: @"wintop"];
    [win addAlias: @"win"];
    [win addAlias: @"jonwintop"];
    [win addAlias: @"JonWINTOP.swxrochester.com"];
    
    Screen *mac = [[Screen alloc] initWithName: @"mactop"];
    [mac addAlias: @"mac"];
    [mac addAlias: @"styx"];
    [mac addAlias: @"Styx.local"];
    [mac addAlias: @"Styx.swxrochester.com"];
    
    [win addLinkToScreen: mac inDirection: Left];
    
    NSMutableArray *screens = [NSMutableArray arrayWithObjects: mac, win, nil];    
    Configuration *config = [[Configuration alloc] initWithScreens: screens];
    return config;
}



@end
