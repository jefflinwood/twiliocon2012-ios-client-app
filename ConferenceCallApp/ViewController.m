//
//  ViewController.m
//  ConferenceCallApp
//
//  Created by Jeffrey Linwood on 10/16/12.
//  Copyright (c) 2012 Jeff Linwood. All rights reserved.
//

#import "ViewController.h"

#import "TCDevice.h"
#import "TCConnection.h"

@interface ViewController ()
@property (nonatomic, strong) TCDevice *device;
@property (nonatomic, strong) TCConnection *connection;

- (void) initTwilioAsync;

@end

@implementation ViewController

- (void) initTwilioAsync {
    NSURL* url = [NSURL URLWithString:@"http://confcallserver.herokuapp.com/token"];

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    if (data) {
        NSHTTPURLResponse*  httpResponse = (NSHTTPURLResponse*)response;
        if (httpResponse.statusCode == 200)
        {
            NSString* capabilityToken =
            [[NSString alloc] initWithData:data
                                  encoding:NSUTF8StringEncoding];
            self.device = [[TCDevice alloc] initWithCapabilityToken:capabilityToken
                                                           delegate:nil];
            self.loggingInLabel.hidden = TRUE;
            self.dialButton.enabled = TRUE;
            self.hangupButton.enabled = FALSE;
            
        }
        else {
            NSLog(@"Error logging in: %@", [error localizedDescription]);
        }
    }

    }];
    
   }




- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initTwilioAsync];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dial:(id)sender {
    self.connection = [self.device connect:nil delegate:nil];
    self.dialButton.enabled = FALSE;
    self.hangupButton.enabled = TRUE;
}

- (IBAction)hangup:(id)sender {
     [self.connection disconnect];
    self.hangupButton.enabled = FALSE;
    self.dialButton.enabled = TRUE;
}
- (void)viewDidUnload {
    [self setDialButton:nil];
    [self setHangupButton:nil];
    [self setLoggingInLabel:nil];
    [super viewDidUnload];
}
@end
