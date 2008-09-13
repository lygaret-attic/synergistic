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
@synthesize name, aliases;

- (id) initWithName: (NSString *) newName andAliases: (NSString *) firstAlias, ...
{
    if (self = [super init])
    {
        name = newName;
        aliases = [[NSMutableArray alloc] init];
        
        {
            id each;
            va_list aliasList;
         
            if (firstAlias) {
                [aliases addObject: firstAlias];

                va_start(aliasList, firstAlias);
                while (each = va_arg(aliasList, id))
                    [aliases addObject: each];
                va_end(aliasList);
            }            
        }
    }

    return self;
}

- (id) init
{
    if (self = [super init]) {
        name = nil;
        aliases = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) dealloc
{
    [name release];
    [aliases release];
    [super dealloc];
}

@end
