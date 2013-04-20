//
//  StatusItemView.m
//  Notation
//
//  Created by elasticthreads on 07/03/2010.
//  Copyright 2010 elasticthreads. All rights reserved.
//

#import "StatusItemView.h"

NSString *imageName = @"nvMenuDark";
static NSRect itemRect;


@implementation StatusItemView

@synthesize sbIconType;


- (id)initWithFrame:(NSRect)frameRect{
    if ((self=[super initWithFrame:frameRect])) {
        itemRect=NSMakeRect(4.0, 3.0, 16.0, 16.0);
        self.sbIconType=DarkMenuIcon;
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    CGFloat fract=1.0;
	if (sbIconType==SelectedMenuIcon) {
        fract=0.87;
        [[NSColor selectedMenuItemColor] setFill];
    }else {
		[[NSColor clearColor] setFill];
	}
    NSRectFill(rect);
    
	[[NSImage imageNamed:imageName] drawInRect:itemRect fromRect:NSZeroRect operation: NSCompositeSourceOver fraction:fract];
}


- (void)mouseDown:(NSEvent *)event
{
    self.sbIconType=SelectedMenuIcon;
    NSUInteger flags=[event modifierFlags];   
    if (((flags&NSDeviceIndependentModifierFlagsMask)==(flags&NSControlKeyMask))&&((flags&NSDeviceIndependentModifierFlagsMask)>0)) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"StatusItemMenuShouldDrop" object:nil];
        self.sbIconType=DarkMenuIcon;
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NVShouldActivate" object:self];
    }
}

- (void)mouseUp:(NSEvent *)event {
    self.sbIconType=DarkMenuIcon;
//	[self viewWillDraw];
}

- (void)rightMouseDown:(NSEvent *)event {
    self.sbIconType=SelectedMenuIcon;
     [[NSNotificationCenter defaultCenter]postNotificationName:@"StatusItemMenuShouldDrop" object:nil];
    self.sbIconType=DarkMenuIcon;
}

- (void)setSbIconType:(StatusIconType)type{
    if (sbIconType!=type) {
        switch (type) {
            case DarkMenuIcon:
                imageName=@"nvMenuDark";
                break;
            case SelectedMenuIcon:
                imageName=@"nvMenuW";
                break;
                
            default:
                imageName=@"nvMenuDark";
                break;
        }
        sbIconType=type;
        [self setNeedsDisplay:YES];
    }
}

@end
