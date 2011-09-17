//
//  TableViewController.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-14.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSFetchedResultsController *resultsController;
}
@property (nonatomic, retain) NSFetchedResultsController *resultsController;
@end
