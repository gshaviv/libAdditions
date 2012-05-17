//
//  NSCoderGSA.m
//  AdditionsLib
//
//  Created by Guy Shaviv on 1/2/11.
//  Copyright 2011 LitePoint Corp. All rights reserved.
//

#import "NSCoderGSA.h"


@implementation NSCoder (GSA)

- (void) encodeIntNumber:(NSInteger)i forKey:(NSString*)key {
	[self encodeObject:[NSNumber numberWithInt:i] forKey:key];
}

- (void) encodeFloatNumber:(float)n forKey:(NSString*)key {
	[self encodeObject:[NSNumber numberWithFloat:n] forKey:key];
}

- (void) encodeBoolNumber:(BOOL)n forKey:(NSString*)key {
	[self encodeObject:[NSNumber numberWithBool:n] forKey:key];
}

- (NSUInteger) decodeUnsignedIntNumberForKey:(NSString*)key default:(NSUInteger)d {
	NSNumber *n = [self decodeObjectForKey:key];
	return n ? [n unsignedIntValue] : d;
}

- (NSInteger) decodeIntNumberForKey:(NSString*)key default:(NSInteger)d {
	NSNumber *n = [self decodeObjectForKey:key];
	return n ? [n intValue] : d;
}
- (float) decodeFloatNumberForKey:(NSString*)key default:(float)d {
	NSNumber *n = [self decodeObjectForKey:key];
	return n ? [n floatValue] : d;
}
- (BOOL) decodeBoolNumberForKey:(NSString*)key default:(BOOL)d {
	NSNumber *n = [self decodeObjectForKey:key];
	return n ? [n boolValue] : d;
}

@end
