//
//  DSTwitterViewController.h
//  devinsantos
//
//  Created by Fernando Ribeiro on 10/19/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"

@interface DSTwitterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
