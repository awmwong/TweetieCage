//
//  ImageFetchOperation.m
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-20.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import "ImageFetchOperation.h"

@implementation ImageFetchOperation
@synthesize imageURL;
@synthesize delegate;
@synthesize tableCell;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithURL:(NSURL *)theImageURL andCell:(TCTableViewCell*)theCell
{
    self = [self init];
    
    if (!self)
        return nil;
    
    self.imageURL = theImageURL;
    self.tableCell = theCell;
    
    return self;
}

- (void) main
{
    if (self.isCancelled) return;
    if (nil == self.imageURL) return;
    
    NSData *imageData = [NSData dataWithContentsOfURL:[self imageURL]];
    if (imageData == nil) return;
    if (self.isCancelled) return;
    
    UIImage *img = [UIImage imageWithData:imageData];
    if (img == nil)
    {
        NSLog(@"Something went wrong with image from data");
        return;
    }
    if (self.isCancelled) return;
    
    NSMutableArray *retArray = [[[NSMutableArray alloc] initWithObjects:img, [self tableCell], nil] autorelease];
    [delegate performSelectorOnMainThread:@selector(imageReady:) withObject:retArray waitUntilDone:YES];
}
@end
