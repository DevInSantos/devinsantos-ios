//
//  DSMapViewController.m
//  devinsantos
//
//  Created by Fernando Bass on 10/18/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "DSMapViewController.h"
#import "DSPin.h"
#import "LoadingView.h"

@interface DSMapViewController ()
{
    LoadingView *loadingView;
}
@end

@implementation DSMapViewController

- (void)viewDidLoad
{
    loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.event.address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        [self.mapView setCenterCoordinate:placemark.location.coordinate animated:YES];
        
        DSPin *pin = [[DSPin alloc] init];
        pin.title = self.event.place;
        pin.subtitle = self.event.address;
        pin.coordinate = placemark.location.coordinate;
        
        [self.mapView addAnnotation:pin];
        
        MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
        MKCoordinateRegion region = MKCoordinateRegionMake(placemark.location.coordinate, span);
        
        [self.mapView setRegion:region animated:YES];
        
    }];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    [loadingView showOnView:self.view animated:YES];
    
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [loadingView hideAnimated:YES];
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    [loadingView hideAnimated:YES];
}

@end
