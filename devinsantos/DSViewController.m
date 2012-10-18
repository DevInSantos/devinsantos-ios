//
//  DSViewController.m
//  devinsantos
//
//  Created by Fernando Bass on 10/18/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "DSViewController.h"
#import "AFNetworking.h"

@interface DSViewController ()

@end

@implementation DSViewController

- (void)loadEvents
{
    NSURL *url = [NSURL URLWithString:@"http://devinsantos-events.herokuapp.com/events.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
    }];
    
    [operation start];
}

- (void)viewDidLoad
{
    [self loadEvents];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDateLabel:nil];
    [self setTimeLabel:nil];
    [self setAddressLabel:nil];
    [self setLocationLabel:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
