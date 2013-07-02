//
//  NotesTableHeaderCell.h
//  Notation
//
//  Created by David Halter on 6/12/13.
//  Copyright (c) 2013 David Halter. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NotesTableHeaderCell : NSTableHeaderCell {
}

+ (void)setBColor:(NSColor *)inColor;
+ (void)setTxtColor:(NSColor *)inColor;
- (void)drawBorderWithFrame:(NSRect)cellFrame;
- (void)drawGradientFromColor:(NSColor *)baseColor inRect:(NSRect)cellFrame;

@end
