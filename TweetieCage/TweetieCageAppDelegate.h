//
//  TweetieCageAppDelegate.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-13.
//  Copyright 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTableViewController.h"
#import "TCSearchViewController.h"
@interface TweetieCageAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) TCTableViewController *tableViewController;
@property (nonatomic, retain) TCSearchViewController *searchViewController;
@property (nonatomic, retain) NSOperationQueue *backgroundFetchingQueue;
-(void)getDataFromTwitterWithUser:(NSString*)user;

@end
