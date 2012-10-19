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
#import "DSSponsorParser.h"
#import "DSSponsor.h"
#import "DSMapViewController.h"
#import "LoadingView.h"

@interface DSViewController ()
{
    NSArray *eventsArray;
    NSArray *sponsorssArray;
    LoadingView *loadingView;
    int nextSponsor;
}
- (NSDateComponents *)formatDate:(NSString *)date;
- (NSString *)dayOfWeek:(int)weekday;
- (NSString *)month:(int)month;
@end

@implementation DSViewController

- (void)loadEvents
{
    [loadingView showOnView:self.navigationController.view animated:YES];

    NSURL *url = [NSURL URLWithString:@"http://devinsantos-events.herokuapp.com/events.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        eventsArray = [NSArray arrayWithArray:[DSEventParser parseEventWithJSON:JSON]];
        [self mountView];
        [self loadSponsors];
        [loadingView hideAnimated:YES];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [loadingView hideAnimated:YES];

    }];
    
    [operation start];
}

- (void)loadSponsors
{
    [loadingView showOnView:self.navigationController.view animated:YES];
    DSEvent *event = [eventsArray objectAtIndex:0];
    NSString *urlString = [NSString stringWithFormat:@"http://devinsantos-events.herokuapp.com/events/%d/sponsors.json", event.eventId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        sponsorssArray = [NSArray arrayWithArray:[DSSponsorParser parseSponsorWithJSON:JSON]];
        [loadingView hideAnimated:YES];
        [self mountSponsorsCarrousel];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [loadingView hideAnimated:YES];
        
    }];
    
    [operation start];
}

- (void)mountSponsorsCarrousel
{
    [loadingView showOnView:self.navigationController.view animated:YES];
    int i = 0;
    for (DSSponsor *sponsor in sponsorssArray) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|
                                      UIViewAutoresizingFlexibleWidth|
                                      UIViewAutoresizingFlexibleRightMargin|
                                      UIViewAutoresizingFlexibleTopMargin|
                                      UIViewAutoresizingFlexibleHeight|
                                      UIViewAutoresizingFlexibleBottomMargin);

        NSURL *url = [NSURL URLWithString:sponsor.logo];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            imageView.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            [loadingView hideAnimated:YES];
        }];
        
        [self.scrollView addSubview:imageView];
        imageView = nil;
        i++;
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width * sponsorssArray.count, self.scrollView.frame.size.height)];
    [self sponsorsCarrouselStartAnimate];
    [loadingView hideAnimated:YES];
}

- (void)sponsorsCarrouselStartAnimate
{
    if (nextSponsor >= sponsorssArray.count || !nextSponsor) {
        nextSponsor = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * nextSponsor, 0)];
    [self performSelector:_cmd withObject:nil afterDelay:4];
    nextSponsor++;
}

- (void)mountView
{
    DSEvent *event = [eventsArray objectAtIndex:0];
    NSDateComponents *dateComponents = [self formatDate:event.date];
    self.titleLabel.text = event.name;
    self.addressTextView.text = event.address;
    self.dateLabel.text = [NSString stringWithFormat:@"%@, %02i de %@, %d", [self dayOfWeek:dateComponents.weekday], dateComponents.day ,[self month:dateComponents.month], dateComponents.year];    
}

#pragma mark - DateComponents

- (NSString *)month:(int)month
{
    NSString *_month;
    switch (month) {
        case 1:
            _month = @"Janeiro";
            break;
        case 2:
            _month = @"Fevereiro";
            break;
        case 3:
            _month = @"Março";
            break;
        case 4:
            _month = @"Abril";
            break;
        case 5:
            _month = @"Maio";
            break;
        case 6:
            _month = @"Junho";
            break;
        case 7:
            _month = @"Julho";
            break;
        case 8:
            _month = @"Agosto";
            break;
        case 9:
            _month = @"Setembro";
            break;
        case 10:
            _month = @"Outubro";
            break;
        case 11:
            _month = @"Novembro";
            break;
        case 12:
            _month = @"Dezembro";
            break;
        default:
            break;
    }
    return _month;
}

- (NSString *)dayOfWeek:(int)weekday
{
    NSString *dayOfWeek;
    
    switch (weekday) {
        case 1:
            dayOfWeek = @"Domingo";
            break;
        case 2:
            dayOfWeek = @"Segunda";
            break;
        case 3:
            dayOfWeek = @"Terça";
            break;
        case 4:
            dayOfWeek = @"Quarta";
            break;
        case 5:
            dayOfWeek = @"Quinta";
            break;
        case 6:
            dayOfWeek = @"Sexta";
            break;
        case 7:
            dayOfWeek = @"Sábado";
            break;            
        default:
            break;
    }
    return dayOfWeek;
}

- (NSDateComponents *)formatDate:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'-02:00'"];
    NSDate *_date = [dateFormatter dateFromString:date];
    
    NSUInteger flags = NSDayCalendarUnit | kCFCalendarUnitMonth | kCFCalendarUnitWeekday| kCFCalendarUnitYear| NSHourCalendarUnit | NSMinuteCalendarUnit;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:flags fromDate:_date];
    
    return dateComponents;
}

- (void)viewDidLoad
{
    loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"texture"]]];
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
    [self setTitleLabel:nil];
    [self setDateLabel:nil];
    [self setAddressTextView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

#pragma mark - UIStoryBoardSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mapSegue"]) {
        DSMapViewController *map = (DSMapViewController *)[segue destinationViewController];
        map.event = [eventsArray objectAtIndex:0];
    }
}

- (IBAction)eventSubscription {
    DSEvent *event = [eventsArray objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:event.subscriptionUrl];
    [[UIApplication sharedApplication] openURL:url];
}
@end
