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
- (NSDateComponents *)formatDate:(NSString *)date;
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
    
    self.title = event.name;
    NSDateComponents *dateComponents = [self formatDate:event.date];
    self.calendarDay.text = [NSString stringWithFormat:@"%02i", dateComponents.day];
    
}

- (NSDateComponents *)formatDate:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'-02:00'"];
    NSDate *_date = [dateFormatter dateFromString:date];
    
    NSUInteger flags = NSDayCalendarUnit | kCFCalendarUnitMonth | kCFCalendarUnitYear| NSHourCalendarUnit | NSMinuteCalendarUnit;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:flags fromDate:_date];
    
    return dateComponents;
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
    [self setScrollView:nil];
    [self setCalendarDay:nil];
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
