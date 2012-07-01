//
//  NSDictionaryAdditions.m
//  houzz
//
//  Created by Guy Shaviv on 25/2/10.
//  Copyright 2010 . All rights reserved.
//

#import "NSDictionaryAdditions.h"


@implementation NSDictionary (Additions)

- (NSInteger) integerForKey:(id)key {
	return [self integerForKey:key default:0];
}

- (NSInteger) integerForKey:(id)key default:(NSInteger)defaultValue {
	id num = [self objectForKey:key];
	if (num) {
		return [num intValue];
	}
	return defaultValue;
}

- (NSUInteger) unsignedIntegerForKey:(id)key default:(NSUInteger)defaultValue {
	id num = [self objectForKey:key];
	if (num) {
		return [num unsignedIntegerValue];
	}
	return defaultValue;
}

- (NSUInteger) unsignedIntegerForKey:(id)key {
	return [self unsignedIntegerForKey:key default:0];
}
- (BOOL) boolForKey:(id)key {
	NSNumber* num = [self objectForKey:key];
	if (num == nil) {
		return NO;
	}
	return [num boolValue];
}
- (float) floatForKey:(id)key  {
	id num = [self objectForKey:key];
	if (num) {
		return [num floatValue];
	}
	return 0;
}
- (CGRect) rectForKey:(id)key {
    id v = [self objectForKey:key];
    if (v) {
        return [v CGRectValue];
    } else {
        return CGRectZero;
    }
}
@end

@implementation NSMutableDictionary (Additions)

- (void) setInteger:(NSInteger)i forKey:(id)key {
	[self setObject:[NSNumber numberWithInt:i] forKey:key];
}
- (void) setUnsignedInteger:(NSUInteger)i forKey:(id)key {
	[self setObject:[NSNumber numberWithUnsignedInt:i] forKey:key];
}
- (void) setFloat:(Float32)f forKey:(id)key {
    [self setObject:[NSNumber numberWithFloat:f] forKey:key];
}
- (void) setCGRect:(CGRect)rect forKey:(id)key {
    [self setObject:[NSValue valueWithCGRect:rect] forKey:key];
}

@end
