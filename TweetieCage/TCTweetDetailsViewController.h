//
//  TCTweetDetailsViewController.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-23.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@interface TCTweetDetailsViewController : UIViewController

@property(nonatomic, retain) IBOutlet UILabel* fullName;
@property(nonatomic, retain) IBOutlet UILabel* userName;
@property(nonatomic, retain) IBOutlet UILabel* content;
@property(nonatomic, retain) IBOutlet UILabel* date;
@property(nonatomic, retain) IBOutlet UIImageView* portrait;
@property(nonatomic, retain) Tweet* tweet;
@property(nonatomic, retain) NSOperationQueue* imgQ;
@end
