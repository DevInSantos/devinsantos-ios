//
//  DSTwitterParser.h
//  devinsantos
//
//  Created by Fernando Ribeiro on 10/19/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSTwitterParser : NSObject
+ (NSArray *)parseTwitterWithJSON:(NSArray *)JSON;

@end
