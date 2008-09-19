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

- (id) init
{
    if (self = [super init]) {
        screens = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id) initWithContentsOfFile: (NSString *) filename;
{
    // TODO
    [[NSException exceptionWithName: @"Not Implemented" reason: @"Not yet implemented." userInfo: nil] raise];
    return self;
}

- (id) initWithScreens: (NSArray *) newScreens
{
    if (self = [super init]) {
        screens = [[NSMutableDictionary alloc] init];
        for(Screen *s in newScreens) {
            [screens setObject:s forKey:s.name];
        }
    }
    
    return self;
}

- (void) addScreen: (Screen *) screen
{
    [screens setObject: screen forKey: screen.name];
}

- (void) removeScreen: (Screen *) screen
{
    [self removeScreenNamed: screen.name];
}

- (void) removeScreenNamed: (NSString *) name
{
    [screens removeObjectForKey: name];
}

- (NSArray *) getScreens
{
    // calling this, don't forget to retain!
    return [screens allValues];
}

- (void) dealloc
{
    [screens release];
    [super dealloc];
}

@end
