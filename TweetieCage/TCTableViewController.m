//
//  TableViewController.m
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-14.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import "TCTableViewController.h"
#import "TCTableViewCell.h"
#import "NSDate+Helper.h"
@implementation TCTableViewController

@synthesize tableView;
@synthesize resultsController;
@synthesize portraitDict;
@synthesize imageQ;

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
    
    imageQ = [[NSOperationQueue alloc]init];
    portraitDict = [[NSMutableDictionary alloc] init];
    
    NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"Tweet" inManagedObjectContext:context];
    
    [fetchRequest setEntity:ed];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    [sortDescriptors release];
    [sortDescriptor release];
    
    resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error;
    BOOL success = [resultsController performFetch:&error];
    
    if (!success)
        NSLog(@"Something went bad during the fetch!");
    
    tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [fetchRequest release];
    
    
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
    [portraitDict dealloc];
    [imageQ dealloc];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[resultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[resultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) 
        dateFormatter = [[NSDateFormatter alloc] init];
    static NSString *CellIdentifier = @"Cell";
    
    TCTableViewCell *cell = (TCTableViewCell*)[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSManagedObject *managedObject = [resultsController objectAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[TCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }   
    
    cell.dateLabel.text =[NSDate stringForDisplayFromDate:[managedObject valueForKey:@"date"]];
    cell.userLabel.text = [managedObject valueForKey:@"name"];
    cell.contentLabel.text = [managedObject valueForKey:@"text"];
    
    //Resize logic
    UILabel *lbl = cell.contentLabel;
    CGRect cellFrame = [cell frame];
    [lbl setFrame:CGRectMake(X_OFFSET, Y_OFFSET, TEXT_WIDTH, TEXT_HEIGHT)];
    [lbl sizeToFit];
    if(lbl.frame.size.height > TEXT_HEIGHT)
    {
        cellFrame.size.height = ROW_HEIGHT + lbl.frame.size.height - TEXT_HEIGHT;
    }
    else
    {
        cellFrame.size.height = ROW_HEIGHT;
    }
    
    [cell setFrame:cellFrame];
    
    
    NSString *urlString = [managedObject valueForKey:@"imgurl"];
    __block UIImage *img = [self.portraitDict objectForKey:urlString];
    
    if (img == nil) //doesn't already exist in cache
    {
        //Attempt #5 at image caching;
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(void){  
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            img = [UIImage imageWithData:imageData];
            if (img == nil)
            {
                NSLog(@"Something went wrong with image from data");
            } 
            else
            {
                [self.portraitDict setObject:img forKey:urlString];
            }
        }];
        
        [operation setCompletionBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (img == nil) return;
                [cell.portrait setImage:img]; 
            }];
            
        }];
        
        [imageQ addOperation:operation];
    } else
    {
        [cell.portrait setImage:img];
    }


    cell.contentView.backgroundColor = indexPath.row % 2? [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1]: [UIColor whiteColor];
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
}

- (CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [self tableView:theTableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

@end
