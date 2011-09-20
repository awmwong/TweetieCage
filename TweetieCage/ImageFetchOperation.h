//
//  ImageFetchOperation.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-20.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCTableViewCell.h"
@protocol ImageFetchOperationDelegate

- (void) imageReady:(NSArray*)args;

@end

@interface ImageFetchOperation : NSOperation
{
    id delegate;
    NSURL *imageURL;
    TCTableViewCell *tableCell;
}

- (id) initWithURL:(NSURL*) imageURL andCell:(TCTableViewCell*) theCell;

@property (nonatomic, retain) NSURL *imageURL;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) TCTableViewCell *tableCell;

@end

