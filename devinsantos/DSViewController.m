//
//  DSViewController.m
//  devinsantos
//
//  Created by Fernando Bass on 10/18/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "DSViewController.h"
#import "AFNetworking.h"
#import "DSEventParser.h"
#import "DSEvent.h"
#import "DSMapViewController.h"

@interface DSViewController ()
{
    NSArray *array;
}
@end

@implementation DSViewController

- (void)loadEvents
{
    NSURL *url = [NSURL URLWithString:@"http://devinsantos-events.herokuapp.com/events.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        array = [NSArray arrayWithArray:[DSEventParser parseEventWithJSON:JSON]];
        [self mountView];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
    }];
    
    [operation start];
}

- (void)mountView
{
    DSEvent *event = [array objectAtIndex:0];

    self.dateLabel.text = event.date;
    self.placeLabel.text = event.place;
    self.addressLabel.text = event.address;
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
    [self setPlaceLabel:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

#pragma mark - UIStoryBoardSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mapSegue"]) {
        DSMapViewController *map = (DSMapViewController *)[segue destinationViewController];
        map.event = [array objectAtIndex:0];
    }
}

- (IBAction)eventSubscription {
    DSEvent *event = [array objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:event.subscriptionUrl];
    [[UIApplication sharedApplication] openURL:url];
}
@end
