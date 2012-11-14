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

- (NSRange) entireStringRange {
    return NSMakeRange(0, self.length);
}

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
	NSMutableArray* pairs = [NSMutableArray array];
    [query enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, [value stringByEscapingToURLSafe]];
		[pairs addObject:pair];
    }];
	
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
			NSString* key = [kvPair[0] stringByReplacingPercentEscapesUsingEncoding:encoding] ; NSString* value = [kvPair[1] stringByReplacingPercentEscapesUsingEncoding:encoding] ;
            pairs[key] = value ;
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
        entityReverseLookup = @{@"%": @"%25",
                               @"!": @"%21",
                               @"#": @"%23",
                               @"$": @"%24",
                               @"&": @"%26",
                               @"'": @"%27",
                               @"(": @"%28",
                               @")": @"%29",
                               @"*": @"%2A",
                               @"+": @"%2B",
                               @",": @"%2C",
                               @"/": @"%2F",
                               @":": @"%3A",
                               @";": @"%3B",
                               @"=": @"%3D",
                               @"?": @"%3F",
                               @"@": @"%40",
                               @"[": @"%5B",
                               @"]": @"%5D",
                               @"\n": @"%0A",
                               @" ": @"%20",
                               @"\"": @"%22",
                               @"-": @"%2D",
                               @".": @"%2E",
                               @"<": @"%3C",
                               @">": @"%3E",
                               @"\\": @"%5C",
                               @"^": @"%5E",
                               @"_": @"%5F",
                               @"`": @"%60",
                               @"{": @"%7B",
                               @"|": @"%7C",
                               @"}": @"%7D",
                               @"~": @"%7E"};
        
    });
    
    NSMutableString *tmpString = [NSMutableString string];
    
    for (NSUInteger i = 0; i<[self length]; i++)
    {
        unichar oneChar = [self characterAtIndex:i];
        
        NSString *subKey = [self substringWithRange:NSMakeRange(i, 1)];
        NSString *entity = entityReverseLookup[subKey];
        
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

- (NSString*) stringByStrippingHTMLTags {
    NSString *htmlStripped = nil;
    @autoreleasepool {
        static NSRegularExpression *tagEx = nil;
        static NSRegularExpression *spaceEx = nil;
        if (!tagEx) {
            tagEx = [NSRegularExpression regularExpressionWithPattern:@"< *(\\/?)([-A-Za-z0-9._]+) *(.*?)(\\/?)>" options:NSRegularExpressionCaseInsensitive error:nil];
            spaceEx = [NSRegularExpression regularExpressionWithPattern:@"  +" options:0 error:nil];
        }
        NSString *brStripped = [self stringByReplacingOccurrencesOfString:@"<br/>" withString:@" "];
        htmlStripped = [tagEx stringByReplacingMatchesInString:brStripped options:NSRegularExpressionCaseInsensitive range:NSRangeMake(0, brStripped.length) withTemplate:@""];
        htmlStripped = [spaceEx stringByReplacingMatchesInString:htmlStripped options:0 range:NSRangeMake(0, htmlStripped.length) withTemplate:@" "];
    }
    return htmlStripped;
}


@end
