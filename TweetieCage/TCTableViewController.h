//
//  TableViewController.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-14.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageFetchOperation.h"
@interface TCTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSFetchedResultsController *resultsController;
@property (nonatomic, retain) NSMutableDictionary *portraitDict;
@property (nonatomic, retain) NSOperationQueue *imageQ;
@property (nonatomic, retain) UITableView *tableView;
@end
