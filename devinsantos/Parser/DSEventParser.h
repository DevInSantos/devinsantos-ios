//
//  DSEventParser.h
//  devinsantos
//
//  Created by Fernando Bass on 10/18/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSEventParser : NSObject

+ (NSArray *)parseEventWithJSON:(NSArray *)JSON;
@end
