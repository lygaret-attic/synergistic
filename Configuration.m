//
//  Configuration.m
//  Synergistic
//
//  Synergistic is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//  Created by Jon Raphaelson on 9/12/08.
//  Copyright 2008 Jon Raphaelson. All rights reserved.
//

#import "Configuration.h"
#import "Screen.h"
#import "Link.h"

@implementation Configuration
@synthesize screens, links;

+ (Configuration *) sampleConfiguration
{
    Screen *win = [[Screen alloc] initWithName: @"wintop" andAliases: @"win", @"jonwintop", @"JonWINTOP.swxrochester.com", nil];
    Screen *mac = [[Screen alloc] initWithName: @"mactop" andAliases: @"mac", @"styx", @"Styx.local", @"Styx.swxrochester.com", nil];    

    NSMutableArray *screens = [NSMutableArray arrayWithObjects: mac, win, nil];

    NSMutableArray *links = [NSMutableArray array];
    [links addObject: [[Link alloc] initWithParent: mac Child: win inDirection: Left]];
    [links addObject:[[Link alloc] initWithParent: win Child: mac inDirection: Right]];
    
    Configuration *config = [[Configuration alloc] initWithScreens: screens andLinks: links];    
    return config;
}

/*
+ (Configuration *) configurationFromFileNamed: (NSString *path)
{
    
}
*/

- (id) init
{
    if (self = [super init])
    {
        screens = [[NSMutableArray alloc] init];
        links   = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id) initWithScreens: (NSArray *) newScreens andLinks: (NSArray *) newLinks
{
    if (self = [super init]) {
        screens = [[NSMutableArray arrayWithArray: newScreens] retain];
        links   = [[NSMutableArray arrayWithArray: newLinks] retain];
    }
    
    return self;
}

- (void) dealloc
{
    [screens release];
    [links release];
    [super dealloc];
}

@end
