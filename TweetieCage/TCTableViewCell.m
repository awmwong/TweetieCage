//
//  TCTableViewCell.m
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-19.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import "TCTableViewCell.h"

@implementation TCTableViewCell
@synthesize contentLabel, userLabel, dateLabel;
@synthesize portrait;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect rect = [self frame];
        UIView *theContentView = self.contentView;
        
        //Portrait
        rect = CGRectMake(PADDING, (ROW_HEIGHT - IMAGE_SIZE) / 2.0, IMAGE_SIZE, IMAGE_SIZE);
        portrait = [[UIImageView alloc]initWithFrame:rect];
        [theContentView addSubview:portrait];
        [portrait release];
        
        //Username Label
        rect = CGRectMake(X_OFFSET, PADDING, LABEL_WIDTH, LABEL_HEIGHT);
        userLabel = [[UILabel alloc]initWithFrame:rect];
        userLabel.highlightedTextColor = [UIColor whiteColor];
        userLabel.textColor = [UIColor blackColor];
        userLabel.backgroundColor = [UIColor clearColor];
        userLabel.textAlignment = UITextAlignmentLeft;
        [theContentView addSubview:userLabel];
        [userLabel release];
        
        //Date Label
        rect = CGRectMake(X_OFFSET + LABEL_WIDTH, PADDING, LABEL_WIDTH, LABEL_HEIGHT);
        dateLabel = [[UILabel alloc] initWithFrame:rect];
        dateLabel.highlightedTextColor = [UIColor whiteColor];
        dateLabel.textColor = [UIColor lightGrayColor];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.textAlignment = UITextAlignmentRight;
        dateLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        [theContentView addSubview:dateLabel];
        [dateLabel release];
        
        //Content Label
        rect = CGRectMake(X_OFFSET, 10 + LABEL_HEIGHT, (320 - X_OFFSET - PADDING), 10);
        contentLabel = [[UILabel alloc] initWithFrame:rect];
        contentLabel.highlightedTextColor = [UIColor whiteColor];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.lineBreakMode = UILineBreakModeWordWrap;
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:12.0];
        [theContentView addSubview:contentLabel];
        [contentLabel release];
        
        //ns operation finishes, block, don't cancel ns operation. 
        //ivar operation and check for self assignment..
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}
@end
