//
//  TableViewController.m
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-14.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import "TCTableViewController.h"
#import "TCTableViewCell.h"
#import "TCTweetDetailsViewController.h"
#import "NSDate+Helper.h"
#import "Tweet.h"
@interface TCTableViewController (private)
-(void) configureCell:(TCTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;
@end
@implementation TCTableViewController

@synthesize tableView = _tableView; //shortcut to create iVars
@synthesize resultsController = _resultsController;
@synthesize portraitDict = _portraitDict;
@synthesize imageQ = _imageQ;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)]autorelease];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.imageQ = [[[NSOperationQueue alloc] init] autorelease] ;
    self.portraitDict = [[[NSMutableDictionary alloc] init] autorelease]; 
    
    NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];
    
    self.resultsController = [Tweet fetchAllSortedBy:@"date" ascending:NO withPredicate:nil groupBy:nil inContext:context];
    self.resultsController.delegate = self;
    NSError *error;
    BOOL success = [self.resultsController performFetch:&error];
    
    if (!success)
    {
        NSLog(@"Something went bad during the fetch!");
    }
    
    
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}
- (void)viewDidLoad
{
    /*NSArray *array = [[NSArray alloc] initWithObjects:@"Row 1", @"Row 2", @"Row 3", nil];
    tableData = array; */
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Tweets";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void) dealloc
{
    //free self stuff
    self.portraitDict = nil;
    self.imageQ = nil;
    self.resultsController.delegate = nil;
    self.resultsController = nil;
    self.tableView = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSInteger retVal = [[self.resultsController sections] count];
    return retVal;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.resultsController sections] objectAtIndex:section];
    NSInteger retVal = [sectionInfo numberOfObjects];
    return retVal;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";
    TCTableViewCell *cell = (TCTableViewCell*)[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[TCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    Tweet *tweet = (Tweet*) [self.resultsController objectAtIndexPath:indexPath];
    
    TCTweetDetailsViewController *detailsViewController = [[[TCTweetDetailsViewController alloc] initWithNibName:@"TCTweetDetailsView" bundle:nil] autorelease];
    detailsViewController.tweet = tweet;
    
    [self.navigationController pushViewController:detailsViewController animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    Tweet *tweet = (Tweet*) [self.resultsController objectAtIndexPath:indexPath];
    CGFloat retVal = [TCTableViewCell heightForCellWithWidth:self.view.frame.size.width text:tweet.text];
    return retVal;

}


#pragma mark - NSFetchedResultsController delegates
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(TCTableViewCell*) [tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

-(void) configureCell:(TCTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    Tweet *tweet = (Tweet*) [self.resultsController objectAtIndexPath:indexPath];
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) 
        dateFormatter = [[NSDateFormatter alloc] init];

    
    cell.dateLabel.text =[NSDate stringForDisplayFromDate:tweet.date];
    cell.userLabel.text = tweet.name;
    cell.textView.text = tweet.text;
    
    NSString *urlString = tweet.imgurl;
    UIImage *img = [self.portraitDict objectForKey:urlString];
    
    if (img == nil) //doesn't already exist in cache
    {
        cell.imgURL = urlString; // set the url so we can check when operation completes
        
        //Attempt #5 at image caching;
        [self.imageQ addOperationWithBlock:^(void){  
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            UIImage* img = [UIImage imageWithData:imageData];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (img == nil)
                {
                    NSLog(@"Something went wrong with image from data");
                } 
                else
                {
                    [self.portraitDict setObject:img forKey:urlString];
                    if ([cell.imgURL isEqual:urlString])
                    {//makes sure the cell hasn't been reused while background stuff is going on.
                        [cell.portrait setImage:img]; 
                    }
                }
            }];
            
        }];
        
    } else
    {
        [cell.portrait setImage:img];
    }
    
    cell.contentView.backgroundColor = indexPath.row % 2? [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1]: [UIColor whiteColor];

}
@end
