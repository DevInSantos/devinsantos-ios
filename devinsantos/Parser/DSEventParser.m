//
//  DSEventParser.m
//  devinsantos
//
//  Created by Fernando Bass on 10/18/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "DSEventParser.h"
#import "DSEvent.h"

@implementation DSEventParser

+ (NSArray *)parseEventWithJSON:(NSArray *)JSON
{
    NSMutableArray *events = [[NSMutableArray alloc] init];
    
    for (NSDictionary *_event in JSON) {
        
        DSEvent *event = [[DSEvent alloc] init];
        event.name = [_event valueForKey:@"name"];
        event.description = [_event valueForKey:@"description"];
        event.date = [_event valueForKey:@"date"];
        event.address = [_event valueForKey:@"address"];
        event.place = [_event valueForKey:@"place"];
        
        [events addObject:event];
        event = nil;
    }
    
    return events;
}
@end
