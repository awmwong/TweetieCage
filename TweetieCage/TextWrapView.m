//
//  TextWrapView.m
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-22.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import "TextWrapView.h"

@implementation TextWrapView
@synthesize text = _text;
@synthesize selected = _selected;
 
-(void) setText:(NSString *)theText
{
    [theText retain];
    [_text release];
    _text = theText;
    [self setNeedsDisplay];
}

-(void) setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.selected ? [[UIColor blackColor]set] : [[UIColor whiteColor]set];
    [self.text drawInRect:self.bounds withFont:[UIFont systemFontOfSize:12.0] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
}

-(void) dealloc
{
    self.text = nil;
    [super dealloc];
}
@end

