//
//  TCSearchViewController.h
//  TweetieCage
//
//  Created by Anthony Wong on 11-09-26.
//  Copyright 2011 Cleverest Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCSearchViewController : UIViewController <UITextFieldDelegate>

- (IBAction)goButton:(id)sender;
@property (nonatomic, retain) IBOutlet UITextField *textField;



@end
