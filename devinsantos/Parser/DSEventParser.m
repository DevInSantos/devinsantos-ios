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
        event.name = [JSON valueForKey:@"name"];
        event.description = [JSON valueForKey:@"description"];
        event.date = [JSON valueForKey:@"date"];
        event.address = [JSON valueForKey:@"address"];
        event.place = [JSON valueForKey:@"place"];
        
        [events addObject:_event];
    }
    
    return events;
}
@end
