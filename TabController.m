//
//  TabController.m
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

#import "TabController.h"
#import "ViewToolbarItem.h"

const int STATUSBAR_HEIGHT = 20;

@implementation TabController

@synthesize currentView;

- (void) awakeFromNib
{
    [self switchToView: initialView sized: [initialView frame].size animate: NO];
}

- (IBAction) switchView: (ViewToolbarItem *) vti
{
    if (currentView != vti.windowView) {
        [self switchToView: vti.windowView sized: vti.windowViewSize animate: YES];        
    }
}

- (void) switchToView: (NSView *) newView sized: (NSSize) size animate: (BOOL) animate
{
    NSRect newWindowFrame   = [window frame];
    NSRect newViewFrame     = [currentView frame];
    
    NSRect windowFrame      = [window frame];
    NSRect contentFrame     = [window contentRectForFrameRect: windowFrame];
    int toolbarHeight       = windowFrame.size.height - contentFrame.size.height;
    
    newViewFrame.origin     = NSMakePoint(0, 0);
    newViewFrame.size       = size;
    
    newWindowFrame.size     = NSMakeSize(size.width, size.height + STATUSBAR_HEIGHT + toolbarHeight);
    newWindowFrame.origin.x = windowFrame.origin.x;
    newWindowFrame.origin.y = windowFrame.origin.y + windowFrame.size.height - newWindowFrame.size.height;        
    
    // replace the views
    if (currentView) {
        [[window contentView] replaceSubview: currentView with: newView];        
    }
    else {
        [[window contentView] addSubview: newView];
    }

    // save our copy of the view
    currentView = [newView retain];    
    
    [[currentView superview] setNeedsDisplayInRect: newViewFrame];
    [currentView setFrame: newViewFrame];
    [currentView setNeedsDisplay: YES];
    
    [window setFrame: newWindowFrame display: YES animate: animate];        
}

@end
