//
//  NSStringAdditions.m
//  HotVOD
//
//  Created by Guy Shaviv on 12/31/09.
//  Copyright 2009 .. All rights reserved.
//

#import "NSStringAdditions.h"


@implementation NSString (Additions)

- (int) hexValue {
	int n = 0;
	sscanf([self UTF8String], "%x", &n);
	return n;
}

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
	NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [query keyEnumerator]) {
		NSString* value = [query objectForKey:key];
		value = [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
		NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
		[pairs addObject:pair];
	}
	
	NSString* params = [pairs componentsJoinedByString:@"&"];
	if ([self rangeOfString:@"?"].location == NSNotFound) {
		return [self stringByAppendingFormat:@"?%@", params];
	} else {
		return [self stringByAppendingFormat:@"&%@", params];
	}
}

- (NSDictionary*)dictionaryFromQueryUsingEncoding: (NSStringEncoding)encoding { 
	NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"] ;
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary] ;
    NSScanner* scanner = [[NSScanner alloc] initWithString:self] ;
    while (![scanner isAtEnd]) {
        NSString* pairString ;
        [scanner scanUpToCharactersFromSet:delimiterSet
                                intoString:&pairString] ;
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL] ;
		NSArray* kvPair = [pairString componentsSeparatedByString:@"="] ;
        if ([kvPair count] == 2) {
			NSString* key = [[kvPair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:encoding] ; NSString* value = [[kvPair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:encoding] ;
            [pairs setObject:value forKey:key] ;
        }
    }

    return [NSDictionary dictionaryWithDictionary:pairs] ;
}


@end
