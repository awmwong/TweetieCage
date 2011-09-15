//
//  TweetieCageAppDelegate.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTableViewController.h"

@interface TweetieCageAppDelegate : NSObject <UIApplicationDelegate>
{
    TCTableViewController *tableViewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) TCTableViewController *tableViewController;

@end
