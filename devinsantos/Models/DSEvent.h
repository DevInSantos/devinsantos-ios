//
//  DSEvent.h
//  devinsantos
//
//  Created by Fernando Bass on 10/18/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSEvent : NSObject
@property (strong) NSString *address;
@property (strong) NSString *date;
@property (strong) NSString *description;
@property (strong) NSString *name;
@property (strong) NSString *place;
@property (strong) NSString *subscriptionUrl;
@property (nonatomic) int eventId;
@end
