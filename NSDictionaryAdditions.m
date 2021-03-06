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
	id num = self[key];
	if (num) {
		return [num intValue];
	}
	return defaultValue;
}

- (NSUInteger) unsignedIntegerForKey:(id)key default:(NSUInteger)defaultValue {
	id num = self[key];
	if (num) {
		return [num unsignedIntegerValue];
	}
	return defaultValue;
}

- (NSUInteger) unsignedIntegerForKey:(id)key {
	return [self unsignedIntegerForKey:key default:0];
}
- (BOOL) boolForKey:(id)key {
	NSNumber* num = self[key];
	if (num == nil) {
		return NO;
	}
	return [num boolValue];
}
- (float) floatForKey:(id)key  {
	id num = self[key];
	if (num) {
		return [num floatValue];
	}
	return 0;
}
- (CGRect) rectForKey:(id)key {
    id v = self[key];
    if (v) {
        return [v CGRectValue];
    } else {
        return CGRectZero;
    }
}
- (NSDictionary*) dictionaryByMergingKeysAndValuesFromDictionary:(NSDictionary*)toMerge {
    if (!toMerge) return self;
    NSMutableDictionary *merge = [NSMutableDictionary dictionaryWithDictionary:self];
    [toMerge enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [merge setObject:obj forKey:key];
    }];
    return merge;
}
@end

@implementation NSMutableDictionary (Additions)
- (void) mergeKeysAndValuesFromDictionary:(NSDictionary*)toMerge {
    if (!toMerge) return;
    [toMerge enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self setObject:obj forKey:key];
    }];
}
- (void) setInteger:(NSInteger)i forKey:(id)key {
	self[key] = @(i);
}
- (void) setUnsignedInteger:(NSUInteger)i forKey:(id)key {
	self[key] = @(i);
}
- (void) setFloat:(Float32)f forKey:(id)key {
    self[key] = @(f);
}
- (void) setCGRect:(CGRect)rect forKey:(id)key {
    self[key] = [NSValue valueWithCGRect:rect];
}

@end
