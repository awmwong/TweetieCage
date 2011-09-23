//
//  TCTweetDetailsViewController.m
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-23.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import "TCTweetDetailsViewController.h"

@implementation TCTweetDetailsViewController
@synthesize userName = _userName, fullName = _fullName, content = _content, date=_date;
@synthesize portrait = _portrait;
@synthesize tweet = _tweet;
@synthesize imgQ = _imgQ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imgQ = [[[NSOperationQueue alloc] init] autorelease];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userName.text = self.tweet.name;
    self.content.text = self.tweet.text;
    [self.content sizeToFit];
    
    CGRect dateFrame = self.date.frame;
    dateFrame.origin.y = (self.content.frame.origin.y) + (self.content.frame.size.height);
    self.date.frame = dateFrame;
    
    [self.imgQ addOperationWithBlock:^(void){  
        NSLog(@"Background firing");
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.tweet.imgurl]];
        UIImage* img = [UIImage imageWithData:imageData];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (img == nil)
            {
                NSLog(@"Something went wrong with image from data");
            } 
            else
            {
                //makes sure the cell hasn't been reused while background stuff is going on.
                [self.portrait setImage:img]; 
            }
        }];
        
    }];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
