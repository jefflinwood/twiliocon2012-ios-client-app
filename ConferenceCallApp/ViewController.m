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

- (void) initTwilio;
@end

@implementation ViewController

- (void) initTwilio {
    NSURL* url = [NSURL URLWithString:@"http://confcallserver.herokuapp.com/token"];
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url]
                                         returningResponse:&response
                                                     error:&error];
    if (data) {
        NSHTTPURLResponse*  httpResponse = (NSHTTPURLResponse*)response;
        if (httpResponse.statusCode == 200)
        {
            NSString* capabilityToken =
            [[NSString alloc] initWithData:data
                                  encoding:NSUTF8StringEncoding];
            self.device = [[TCDevice alloc] initWithCapabilityToken:capabilityToken
                                                           delegate:nil];
        }
        else {
            NSLog(@"Error logging in: %@", [error localizedDescription]);
        }
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initTwilio];
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
}

- (IBAction)hangup:(id)sender {
     [self.connection disconnect];
}
@end
