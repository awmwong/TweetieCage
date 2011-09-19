//
//  TCTableViewCell.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-19.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

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
