//
//  TCTableViewCell.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-19.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PADDING 2
#define IMAGE_SIZE 50
#define LABEL_WIDTH 130
#define LABEL_HEIGHT 20
#define ROW_HEIGHT 70
#define X_OFFSET (2 * PADDING + IMAGE_SIZE)
#define Y_OFFSET (2 * PADDING + LABEL_HEIGHT)
#define TEXT_WIDTH (320 - X_OFFSET - PADDING)
#define TEXT_HEIGHT (ROW_HEIGHT - Y_OFFSET - PADDING)


@interface TCTableViewCell : UITableViewCell
{
    UILabel *userLabel;
    UILabel *contentLabel;
    UILabel *dateLabel;
    UIImageView *portrait;
}

@property (nonatomic, retain) UILabel *userLabel;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UIImageView *portrait;


@end
