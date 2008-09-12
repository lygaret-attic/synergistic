//
//  TabController.h
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
//  Created by Jon Raphaelson on 9/9/08.
//  Copyright 2008 Jon Raphaelson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ViewToolbarItem;

@interface TabController : NSObject {
	IBOutlet NSWindow *window;
    IBOutlet NSView *initialView;
    NSView *currentView;
}

@property(readonly) NSView *currentView;

- (IBAction) switchView: (ViewToolbarItem *) vti;
- (void) switchToView: (NSView *) view sized: (NSSize) size animate: (BOOL) animate;

@end
