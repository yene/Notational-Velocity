//
//  TagEditingManager.m
//  Notation
//
//  Created by elasticthreads on 10/15/10.
//

#import <Cocoa/Cocoa.h>


@interface TagEditingManager : NSObject {
	
    IBOutlet NSPanel *tagPanel;
    IBOutlet NSTextField *tagField;
    BOOL isHappening;
    NSArray *commonTags;
}

@property(retain,nonatomic)NSArray *commonTags;

- (id)initWithDelegate:(id)del commonTags:(NSArray *)cTags atPoint:(NSPoint)centerpoint;
- (NSString *)newMultinoteLabels;
- (void)setTF:(NSString *)inString;
- (void)closeTP:(id)sender;
- (NSTextView *)tagFieldEditor;
- (NSTextField *)tagField;
- (BOOL)isMultitagging;

@end
