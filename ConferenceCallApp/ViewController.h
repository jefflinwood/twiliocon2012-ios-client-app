//
//  ViewController.h
//  ConferenceCallApp
//
//  Created by Jeffrey Linwood on 10/16/12.
//  Copyright (c) 2012 Jeff Linwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *dialButton;
@property (strong, nonatomic) IBOutlet UIButton *hangupButton;
@property (strong, nonatomic) IBOutlet UILabel *loggingInLabel;


- (IBAction)dial:(id)sender;
- (IBAction)hangup:(id)sender;

@end
