//
//  TweetieCageAppDelegate.m
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TweetieCageAppDelegate.h"
#import <YAJLiOS/YAJL.h>

@interface TweetieCageAppDelegate (private)
    // forward declarations for helpers
-(NSArray*)getDataFromTwitter;
@end

@implementation TweetieCageAppDelegate

@synthesize window, tableViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    tableViewController = [[[TCTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    [self getDataFromTwitter];
    [window setRootViewController:tableViewController];
    
    [window makeKeyAndVisible];
    return YES;
}

- (NSArray*) getDataFromTwitter
{
    NSURL *url = [NSURL URLWithString:@"http://search.twitter.com/search.json?q=anthowong&rpp=100"];
    NSData *twitterResponse = [NSData dataWithContentsOfURL:url];
    //NSData *twitterResponse = [[NSData dataWithContentsOfFile:@"/Users/Anthony/Desktop/example.json"] autorelease];
    NSArray *arrayFromData = [twitterResponse yajl_JSON];
    NSDictionary *responseDict = (NSDictionary*)arrayFromData;
    return arrayFromData;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
}

- (void)dealloc
{
    [super dealloc];
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
    */
}

@end