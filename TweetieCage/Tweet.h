//
//  Tweet.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-14.
//  Copyright (c) 2011 Cleverest Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tweet : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imgurl;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * text;

@end
