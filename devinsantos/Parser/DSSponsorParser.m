//
//  DSSponsorParser.m
//  devinsantos
//
//  Created by Fernando Ribeiro on 10/19/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "DSSponsorParser.h"
#import "DSSponsor.h"
@implementation DSSponsorParser

+ (NSArray *)parseSponsorWithJSON:(NSArray *)JSON
{
    NSMutableArray *sponsors = [[NSMutableArray alloc] init];
    
    for (NSDictionary *_sponsor in JSON) {
        
        DSSponsor *sponsor = [[DSSponsor alloc] init];
        sponsor.name = [_sponsor valueForKey:@"name"];
        sponsor.logo = [_sponsor valueForKey:@"logo_url"];
        sponsor.type = [_sponsor valueForKey:@"sponsorship_type"];
        
        [sponsors addObject:sponsor];
        sponsor = nil;
    }
    
    return sponsors;
}

@end
