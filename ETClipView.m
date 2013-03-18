//
//  TestClipView.m
//  TestTextViewApp
//
//  Created by elasticthreads on 8/15/11.
//

#import "ETClipView.h"
#import "GlobalPrefs.h"
#import "AppController.h"


@implementation ETClipView

- (id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        [[GlobalPrefs defaultPrefs] registerForSettingChange:@selector(setMaxNoteBodyWidth:sender:) withTarget:self];
        [[GlobalPrefs defaultPrefs] registerForSettingChange:@selector(setManagesTextWidthInWindow:sender:) withTarget:self];
    }
    return self;
}

//
-(void)setFrame:(NSRect)frameRect
{
    if (([[NSApp delegate]isInFullScreen])||([[GlobalPrefs defaultPrefs] managesTextWidthInWindow])) {
        NSRect docRect = [[self documentView] frame];
        docRect.origin.x=0.0;
        if (frameRect.size.width!=[self frame].size.width) {
            
            //        }
            //        if (!NSEqualRects(frameRect, [self frame])) {
            //            NSLog(@"not equal");
            CGFloat theMax=[[GlobalPrefs defaultPrefs] maxNoteBodyWidth]+(kTextMargins*2);
            if (frameRect.size.width>=(theMax+(kTextMargins/5))){
                CGFloat diff = fabs(frameRect.size.width-theMax);
                diff=round(diff/2);
                frameRect.origin.x=diff;
                frameRect.size.width=theMax;
                docRect.size.width=frameRect.size.width;
                [[self documentView] setFrame:docRect];
            }
        }
    }
    [super setFrame:frameRect];
}


- (void)settingChangedForSelectorString:(NSString*)selectorString{
    if (([selectorString isEqualToString:SEL_STR(setMaxNoteBodyWidth:sender:)])||([selectorString isEqualToString:SEL_STR(setManagesTextWidthInWindow:sender:)])){
        NSRect aRect=[[[self documentView]enclosingScrollView] frame];
        [self clipWidthSettingChanged:aRect];
    }
}

- (void)clipWidthSettingChanged:(NSRect)frameRect{
    if (([[NSApp delegate]isInFullScreen])||([[GlobalPrefs defaultPrefs] managesTextWidthInWindow])) {
        NSRect docRect = [[self documentView] frame];
        docRect.origin.x=0.0;
        BOOL superIt=(frameRect.size.width!=[self frame].size.width);
        
        //        }
        //        if (!NSEqualRects(frameRect, [self frame])) {
        //            NSLog(@"not equal");
        CGFloat theMax=[[GlobalPrefs defaultPrefs] maxNoteBodyWidth]+(kTextMargins*2);
        if (frameRect.size.width>=(theMax+(kTextMargins/5))){
            CGFloat diff = fabs(frameRect.size.width-theMax);
            diff=round(diff/2);
            frameRect.origin.x=diff;
            frameRect.size.width=theMax;
            docRect.size.width=frameRect.size.width;
            [[self documentView] setFrame:docRect];
            superIt=YES;
        }
        if(superIt){
            [super setFrame:frameRect];
        }
    }
    
}

@end
