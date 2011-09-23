//
//  TCTableViewCell.m
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-19.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import "TCTableViewCell.h"
#import "TextWrapView.h"
@implementation TCTableViewCell
@synthesize contentLabel = _contentLabel, userLabel = _userLabel, dateLabel = _dateLabel;
@synthesize portrait =_portrait;
@synthesize imgURL = _imgURL;
@synthesize textView = _textView;
+(CGFloat) heightForCellWithWidth:(CGFloat)width text:(NSString *)text;
{
    CGSize maxTextDrawSize = CGSizeMake(width - X_OFFSET - PADDING, MAXFLOAT);
    CGSize retVal = [text sizeWithFont: [UIFont systemFontOfSize:12.0] constrainedToSize:maxTextDrawSize lineBreakMode:UILineBreakModeWordWrap];
    
    
    return MAX(60, retVal.height + LABEL_HEIGHT + (2*PADDING));
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect rect = [self frame];
        UIView *theContentView = self.contentView;
        
        //Portrait
        rect = CGRectMake(PADDING, PADDING, IMAGE_SIZE, IMAGE_SIZE);
        self.portrait = [[[UIImageView alloc]initWithFrame:rect] autorelease];
        [theContentView addSubview:self.portrait];
        
        //Username Label
        rect = CGRectMake(X_OFFSET, PADDING, LABEL_WIDTH, LABEL_HEIGHT);
        self.userLabel = [[[UILabel alloc]initWithFrame:rect] autorelease];
        self.userLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.userLabel.highlightedTextColor = [UIColor whiteColor];
        self.userLabel.textColor = [UIColor blackColor];
        self.userLabel.backgroundColor = [UIColor clearColor];
        self.userLabel.font = [UIFont systemFontOfSize:14.0];
        self.userLabel.textAlignment = UITextAlignmentLeft;
        [theContentView addSubview:self.userLabel];
        
        //Date Label
        rect = CGRectMake(X_OFFSET + LABEL_WIDTH, PADDING, LABEL_WIDTH, LABEL_HEIGHT);
        self.dateLabel = [[[UILabel alloc] initWithFrame:rect] autorelease];
        self.dateLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.dateLabel.highlightedTextColor = [UIColor whiteColor];
        self.dateLabel.textColor = [UIColor lightGrayColor];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.dateLabel.textAlignment = UITextAlignmentRight;
        self.dateLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        [theContentView addSubview:self.dateLabel];
        
        CGFloat contentY = LABEL_HEIGHT;
        rect = CGRectMake(X_OFFSET, LABEL_HEIGHT, (self.contentView.frame.size.width - X_OFFSET - 3*PADDING), (self.contentView.frame.size.height - LABEL_HEIGHT));
        
        self.textView = [[[TextWrapView alloc] initWithFrame:rect] autorelease];
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.textView.backgroundColor = [UIColor clearColor];
        
        [theContentView addSubview:self.textView];
        
        
//        //Content Label
//        CGFloat height = self.contentView.frame.size.height - PADDING - contentY;
//        
//        self.contentLabel = [[[UILabel alloc] initWithFrame:rect] autorelease];
//        self.contentLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        self.contentLabel.highlightedTextColor = [UIColor whiteColor];
//        self.contentLabel.backgroundColor = [UIColor purpleColor];
//        self.contentLabel.lineBreakMode = UILineBreakModeWordWrap;
//        self.contentLabel.numberOfLines = 0;
//        self.contentLabel.font = [UIFont systemFontOfSize:12.0];
//        [theContentView addSubview:self.contentLabel];
//        
//        self.imgURL = [[[NSString alloc] init] autorelease];
        
        //ns operation finishes, block, don't cancel ns operation. 
        //ivar operation and check for self assignment..
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.textView.selected = YES;
}

- (void)dealloc
{
    self.dateLabel = nil;
    self.contentLabel = nil;
    self.userLabel = nil;
    self.portrait = nil;
    self.imgURL = nil;
    [super dealloc];
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    self.imgURL = nil;
    self.portrait.image = nil;
    
}
@end
