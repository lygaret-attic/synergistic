//
//  Screen.m
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

#import "Screen.h"

@implementation Screen
@synthesize name, aliases, links;

- (id) initWithName: (NSString *) _name
{
    if (self = [super init]) {
        name = [_name retain];
        aliases = [[NSMutableSet alloc] init];
        links = [[NSMutableDictionary alloc] initWithCapacity: 4];
    }
    
    return self;
}

- (void) dealloc
{
    [name release];
    [aliases release];
    [links release];
    [super dealloc];
}

#pragma mark LinkTree methods (data getters, setters)

- (void) addAlias: (NSString *) alias
{
    [aliases addObject: alias];
}

- (void) addAliases: (NSString *) first, ...
{
    id each;
    va_list aliasList;
    
    [aliases addObject: first];
    va_start(aliasList, first);
        while (each = va_arg(aliasList, id))
            [aliases addObject: each];
    va_end(aliasList);
}

- (void) removeAlias: (NSString *) alias
{
    [aliases removeObject: alias];
}

- (void) addLinkToScreen: (Screen *) screen inDirection: (LinkDirection) direction
{
    [links setObject: screen forKey: LinkKeyFromEnum(direction)];
}

- (void) addBiDirectionalLinkToScreen: (Screen *) screen inDirection: (LinkDirection) direction
{
    [self addLinkToScreen: screen inDirection: direction];
    [screen addLinkToScreen: self inDirection: LinkInOppositeDirection(direction)];
}

- (void) removeLinkInDirection: (LinkDirection) direction
{
    [links removeObjectForKey: LinkKeyFromEnum(direction)];
}

- (Screen *) getScreenInDirection: (LinkDirection) direction
{
    return [links objectForKey: LinkKeyFromEnum(direction)];
}

@end