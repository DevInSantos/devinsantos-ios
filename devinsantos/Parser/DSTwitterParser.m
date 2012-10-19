//
//  DSTwitterParser.m
//  devinsantos
//
//  Created by Fernando Ribeiro on 10/19/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "DSTwitterParser.h"
#import "DSTwitter.h"
@implementation DSTwitterParser

+ (NSArray *)parseTwitterWithJSON:(NSArray *)JSON
{
    NSMutableArray *tweets = [[NSMutableArray alloc] init];
    
    for (NSDictionary *_tweet in JSON) {
        
        DSTwitter *tweet = [[DSTwitter alloc] init];
        tweet.name = [_tweet valueForKey:@"from_user"];
        tweet.text = [_tweet valueForKey:@"text"];
        tweet.imageUrlString = [_tweet valueForKey:@"profile_image_url"];

        [tweets addObject:tweet];
        tweet = nil;
    }
    
    return tweets;
}

@end
