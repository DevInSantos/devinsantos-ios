//
//  DSSpeakersViewController.m
//  devinsantos
//
//  Created by Fernando Ribeiro on 10/19/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "DSSpeakersViewController.h"

@interface DSSpeakersViewController ()

@end

@implementation DSSpeakersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"texture"]]];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
