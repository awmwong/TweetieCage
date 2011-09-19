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


#define IMAGE_SIZE 50
#define X_OFFSET (10 + IMAGE_SIZE)
#define LABEL_WIDTH 130
#define LABEL_HEIGHT 20
#define PADDING 2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect rect;
        
        UIView *theContentView = self.contentView;
        
        //Portrait
        rect = CGRectMake(PADDING, PADDING, IMAGE_SIZE, IMAGE_SIZE);
        portrait = [[UIImageView alloc]initWithFrame:rect];
        [theContentView addSubview:portrait];
        [portrait release];
        
        //Username Label
        rect = CGRectMake(X_OFFSET, PADDING, LABEL_WIDTH, LABEL_HEIGHT);
        userLabel = [[UILabel alloc]initWithFrame:rect];
        userLabel.highlightedTextColor = [UIColor whiteColor];
        userLabel.textColor = [UIColor blackColor];
        [theContentView addSubview:userLabel];
        [userLabel release];
        
        //Date Label
        rect = CGRectMake(X_OFFSET + LABEL_WIDTH, PADDING, LABEL_WIDTH, LABEL_HEIGHT);
        dateLabel = [[UILabel alloc] initWithFrame:rect];
        dateLabel.highlightedTextColor = [UIColor whiteColor];
        dateLabel.textColor = [UIColor lightGrayColor];
        dateLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        [theContentView addSubview:dateLabel];
        [dateLabel release];
        
        //Content Label
        rect = CGRectMake(X_OFFSET, 10 + LABEL_HEIGHT, (320 - X_OFFSET - PADDING), 10);
        contentLabel = [[UILabel alloc] initWithFrame:rect];
        contentLabel.highlightedTextColor = [UIColor whiteColor];
        contentLabel.lineBreakMode = UILineBreakModeWordWrap;
        contentLabel.numberOfLines = 0;
        [theContentView addSubview:contentLabel];
        [contentLabel release];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
