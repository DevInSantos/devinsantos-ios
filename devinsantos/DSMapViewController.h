//
//  DSMapViewController.h
//  devinsantos
//
//  Created by Fernando Bass on 10/18/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DSEvent.h"

@interface DSMapViewController : UIViewController <MKMapViewDelegate>
@property (strong) DSEvent *event;
@property (weak) IBOutlet MKMapView *mapView;
@end
