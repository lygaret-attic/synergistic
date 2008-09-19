//
//  ScreenGlobals.m
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
//  Created by Jon Raphaelson on 9/10/08.
//  Copyright 2008 Jon Raphaelson. All rights reserved.
//

#include <Foundation/Foundation.h>
#include "Screen.h"
#include "Link.h"

NSString *LinkLeft = @"Left";
NSString *LinkRight = @"Right";
NSString *LinkAbove = @"Above";
NSString *LinkBelow = @"Below";

NSString *LinkKeyFromEnum(LinkDirection dir) {
    switch (dir) {
        case Left: return LinkLeft;
        case Right: return LinkRight;
        case Above: return LinkAbove;
        case Below: return LinkBelow;
    }
    
    [[NSException exceptionWithName: @"Bad Enum Value!" reason: @"You tried to get a LinkKey from an invalid direction!" userInfo: nil] raise];
    return nil;
}

LinkDirection LinkInOppositeDirection(LinkDirection dir)
{
    switch(dir) {
        case Left: return Right;
        case Right: return Left;
        case Above: return Above;
        case Below: return Below;
    }

    [[NSException exceptionWithName: @"Bad Enum Value!" reason: @"You tried to get the opposite of an invalid direction!" userInfo: nil] raise];
    return -1;
}