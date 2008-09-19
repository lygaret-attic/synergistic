//
//  Screen.h
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

#import <Cocoa/Cocoa.h>

typedef enum { Left, Right, Above, Below } LinkDirection;

APPKIT_EXTERN NSString *LinkLeft;
APPKIT_EXTERN NSString *LinkRight;
APPKIT_EXTERN NSString *LinkAbove;
APPKIT_EXTERN NSString *LinkBelow;
APPKIT_EXTERN NSString *LinkKeyFromEnum(LinkDirection dir);
APPKIT_EXTERN LinkDirection LinkInOppositeDirection(LinkDirection dir);

@interface Screen : NSObject {
    NSString *name;

@private
    NSMutableSet *aliases;
    
    // the keys are directions, the values are other screens
    // if a key does not exist, there is no link in that direction
    NSMutableDictionary *links;
}

@property(retain) NSString *name;
@property(readonly) NSSet *aliases;
@property(readonly) NSDictionary *links;

- (id) initWithName: (NSString *) name;

- (void) addAlias: (NSString *) alias;
- (void) removeAlias: (NSString *) alias;

- (void) addLinkToScreen: (Screen *) screen inDirection: (LinkDirection) direction;
- (void) removeLinkInDirection: (LinkDirection) direction;

- (Screen *) getScreenInDirection: (LinkDirection) direction;

@end
