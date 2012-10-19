//
//  DSViewController.h
//  devinsantos
//
//  Created by Fernando Bass on 10/18/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *calendarDay;
- (IBAction)eventSubscription;

@end
