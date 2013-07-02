//
//  NotesTableHeaderCell.m
//  Notation
//
//  Created by David Halter on 6/12/13.
//  Copyright (c) 2013 David Halter. All rights reserved.
//

#import "NotesTableHeaderCell.h"


NSColor *bColor;
NSColor *tColor;

@implementation NotesTableHeaderCell

+ (void)initialize{
    if (!bColor) {
        bColor = [[[NSColor whiteColor] colorUsingColorSpaceName:NSCalibratedRGBColorSpace] retain];
    }
    if (!tColor) {
        tColor = [[[NSColor blackColor] colorUsingColorSpaceName:NSCalibratedRGBColorSpace] retain];
    }
}

- (id)initTextCell:(NSString *)text{
    if ((self = [super initTextCell:text])) {
        if (!text || (text.length==0)) {
            [self setTitle:@"Title"];
        }
    }
    return self;
}

- (BOOL)isOpaque{
    return YES;
}

- (NSRect)drawingRectForBounds:(NSRect)theRect {
	return NSIntegralRect(NSInsetRect(theRect, 6.0f, 0.0f));
}

- (NSRect)sortIndicatorRectForBounds:(NSRect)theRect{
    theRect=[super sortIndicatorRectForBounds:theRect];
    theRect.origin.y= floorf(theRect.origin.y-0.5f);
    return NSIntegralRect(theRect);
}

- (void)drawSortIndicatorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView ascending:(BOOL)ascending priority:(NSInteger)priority{
	NSLog(@"draw sort");
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{
    cellFrame=NSInsetRect(cellFrame, 0.0f, 1.0f);
    cellFrame.size.height-=1.0f;
    [super drawInteriorWithFrame:cellFrame inView:controlView];
}

- (void)drawWithFrame:(NSRect)inFrame inView:(NSView*)inView{
    [self setTextColor:tColor];
    [self drawGradientFromColor:bColor inRect:inFrame];
    [self drawBorderWithFrame:inFrame];
    [self drawInteriorWithFrame:inFrame inView:inView];
}

- (void)highlight:(BOOL)hBool withFrame:(NSRect)inFrame inView:(NSView *)controlView{
    NSColor *theBack;
    if ([[bColor colorUsingColorSpaceName:NSCalibratedWhiteColorSpace] whiteComponent]<0.5f) {
        theBack=[bColor highlightWithLevel:0.24f];
        [self setTextColor:[tColor highlightWithLevel:0.3f]];
	}else {
        theBack=[bColor shadowWithLevel:0.24f];
        [self setTextColor:[tColor shadowWithLevel:0.3f]];
	}
    [self drawGradientFromColor:theBack inRect:inFrame];
    [self drawBorderWithFrame:inFrame];
    
    [self drawInteriorWithFrame:inFrame inView:controlView];
}



#pragma mark - nvALT additions

- (void)drawBorderWithFrame:(NSRect)cellFrame{
    NSBezierPath* thePath = [NSBezierPath new];
    [thePath removeAllPoints];
    [thePath moveToPoint:NSMakePoint((cellFrame.origin.x + cellFrame.size.width),(cellFrame.origin.y +  cellFrame.size.height))];
    [thePath lineToPoint:NSMakePoint(cellFrame.origin.x,(cellFrame.origin.y +  cellFrame.size.height))];
    if (cellFrame.origin.x>5.0f) {
        [thePath lineToPoint:cellFrame.origin];
    }
    
    [tColor setStroke];
    [thePath setLineWidth:1.3];
    [thePath stroke];
    [thePath release];
}

- (void)drawGradientFromColor:(NSColor *)baseColor inRect:(NSRect)cellFrame{
    
    baseColor = [baseColor colorUsingColorSpaceName:NSCalibratedRGBColorSpace];//[bColor    
    NSColor *startColor = [baseColor blendedColorWithFraction:0.3f ofColor:[[NSColor colorWithCalibratedWhite:0.9f alpha:1.0f] colorUsingColorSpaceName:NSCalibratedRGBColorSpace]];
    
    NSColor *endColor = [baseColor blendedColorWithFraction:0.52f ofColor:[[NSColor colorWithCalibratedWhite:0.1f alpha:1.0f] colorUsingColorSpaceName:NSCalibratedRGBColorSpace]];
 
    
    NSGradient *theGrad = [[NSGradient alloc] initWithColorsAndLocations: startColor, 0.11f,
                                endColor, 0.94f, nil];
    [theGrad drawInRect:cellFrame angle:90.0f];
    [theGrad release];
}

+ (void)setBColor:(NSColor *)inColor{
    if (bColor) {
        [bColor release];
    }
	bColor = [[inColor colorUsingColorSpaceName:NSCalibratedRGBColorSpace] retain];
}

+ (void)setTxtColor:(NSColor *)inColor{
    if (tColor) {
        [tColor release];
    }
	tColor = [[inColor colorUsingColorSpaceName:NSCalibratedRGBColorSpace] retain];
}

@end
