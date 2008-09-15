//
//  NSImage-Extras.m
//
//  Created by Scott Stevenson on 9/28/07.
//  Source may be reused with virtually no restriction. See TheoCacaoLicense.txt

#import "NSImage-Extras.h"
#import <QuartzCore/QuartzCore.h>

@implementation NSImage (Extras)

- (CGImageRef)cgImage
{
	NSData* data = [self TIFFRepresentation];
	return CreateCGImageFromData(data);
}

@end

// from http://developer.apple.com/technotes/tn2005/tn2143.html

CGImageRef CreateCGImageFromData(NSData* data)
{
    CGImageRef        imageRef = NULL;
    CGImageSourceRef  sourceRef;

    sourceRef = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    if(sourceRef) {
        imageRef = CGImageSourceCreateImageAtIndex(sourceRef, 0, NULL);
        CFRelease(sourceRef);
    }

    return imageRef;
}
