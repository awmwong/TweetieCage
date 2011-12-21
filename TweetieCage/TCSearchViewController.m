//
//  TCSearchViewController.m
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-26.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import "TCSearchViewController.h"
#import "TCTweetDetailsViewController.h"

@implementation TCSearchViewController
@synthesize textField = _textField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goButton:(id)sender {
    if ([ self.textField.text isEqualToString:@""])
    {
        //do nothing
    }
    else
    {
        TweetieCageAppDelegate *appDelegate = (TweetieCageAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate getDataFromTwitterWithUser:self.textField.text];
        [self.navigationController pushViewController:appDelegate.tableViewController animated:YES];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.textField)
    {
        [theTextField resignFirstResponder];
    }
    
    return YES;
}

- (void)dealloc {
    self.textField = nil;
    [super dealloc];
}
@end
