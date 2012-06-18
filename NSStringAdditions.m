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
//		value = [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//        value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
		NSString* pair = [NSString stringWithFormat:@"%@=%@", key, [value stringByEscapingToURLSafe]];
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
    NSUInteger queryStart;
    if ((queryStart = [self rangeOfString:@"?"].location) == NSNotFound) {
        queryStart = 0;
    } else {
        queryStart += 1;
    }
	NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"] ;
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary] ;
    NSScanner* scanner = [[NSScanner alloc] initWithString:self] ;
    scanner.scanLocation = queryStart;
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

+ (NSString *)globalUniqueIdentifier
{
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	NSString *str = CFBridgingRelease(CFUUIDCreateString(NULL, uuid));    
	CFRelease(uuid);
	
	return str;
}
                          
- (NSString *)stringByEscapingToURLSafe {
    static NSDictionary *entityReverseLookup = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        entityReverseLookup = [[NSDictionary alloc] initWithObjectsAndKeys:
                               @"%25",@"%",
                               @"%21",@"!",
                               @"%23",@"#",
                               @"%24",@"$",
                               @"%26",@"&",
                               @"%27",@"'",
                               @"%28",@"(",
                               @"%29",@")",
                               @"%2A",@"*",
                               @"%2B",@"+",
                               @"%2C",@",",
                               @"%2F",@"/",
                               @"%3A",@":",
                               @"%3B",@";",
                               @"%3D",@"=",
                               @"%3F",@"?",
                               @"%40",@"@",
                               @"%5B",@"[",
                               @"%5D",@"]",
                               @"%0A",@"\n",
                               @"%20",@" ",
                               @"%22",@"\"",
                               @"%2D",@"-",
                               @"%2E",@".",
                               @"%3C",@"<",
                               @"%3E",@">",
                               @"%5C",@"\\",
                               @"%5E",@"^",
                               @"%5F",@"_",
                               @"%60",@"`",
                               @"%7B",@"{",
                               @"%7C",@"|",
                               @"%7D",@"}",
                               @"%7E",@"~",
                               nil];
        
    });
    
    NSMutableString *tmpString = [NSMutableString string];
    
    for (NSUInteger i = 0; i<[self length]; i++)
    {
        unichar oneChar = [self characterAtIndex:i];
        
        NSString *subKey = [self substringWithRange:NSMakeRange(i, 1)];
        NSString *entity = [entityReverseLookup objectForKey:subKey];
        
        if (entity)
        {
            [tmpString appendString:entity];
        }
        else
        {
            if (oneChar<=255)
            {
                [tmpString appendFormat:@"%C", oneChar];
            }
            else
            {
                [tmpString appendFormat:@"%%26%%23%d;", oneChar];
            }
        }
    }
    
    return tmpString;
}


@end
