//
//  BoxLayer.m
//  Synergistic
//
//  Created by siteworx on 9/24/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BoxLayer.h"
#import "NSImage-Extras.h"

@implementation BoxLayer

- (id) init
{
    self = [super init];
    if (self != nil) {
        // get the image
        NSString *imagePath = [[NSBundle mainBundle] pathForImageResource: @"screen_box"];
        NSImage *image = [[NSImage alloc] initWithContentsOfFile: imagePath];
        CGImageRef boxImage = CGImageRetain([image cgImage]);
        [image release];
        
        // initialize thyself
        self.name = @"image";
        self.contents = (id)boxImage;      
    }
    return self;
}


@end
