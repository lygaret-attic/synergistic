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

@implementation Configuration
@synthesize screens;

+ (Configuration *) sampleConfiguration
{
    NSMutableArray *screens = [NSMutableArray array];
    [screens addObject: [[[Screen alloc] initWithName: @"wintop" andAliases: @"win", @"jonwintop", @"JonWINTOP.swxrochester.com", nil] retain]];
    [screens addObject: [[[Screen alloc] initWithName: @"mactop" andAliases: @"mac", @"styx", @"Styx.local", @"Styx.swxrochester.com", nil] retain]];
     
    Configuration *config = [[Configuration alloc] initWithScreens: screens];
    
    return config;
}

- (id) init
{
    if (self = [super init])
    {
        screens = [[NSMutableArray array] retain];
    }
    
    return self;
}

- (id) initWithScreens: (NSArray *) newScreens
{
    if (self = [super init]) {
        screens = [[NSMutableArray arrayWithArray: newScreens] retain];
    }
    
    return self;
}

- (void) dealloc
{
    [screens release];
    [super dealloc];
}

@end
