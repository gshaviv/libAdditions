//
//  NSDictionaryAdditions.h
//  houzz
//
//  Created by Guy Shaviv on 25/2/10.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (Additions)

- (NSInteger) integerForKey:(id)key;
- (NSInteger) integerForKey:(id)key default:(NSInteger)defaultValue;
- (NSUInteger) unsignedIntegerForKey:(id)key;
- (NSUInteger) unsignedIntegerForKey:(id)key default:(NSUInteger)defaultValue;
- (float) floatForKey:(id)key;
- (BOOL) boolForKey:(id)key;
- (NSNumber*) integerNumberForKey:(id)key;
- (NSNumber*) floatNumberForKey:(id)key;
@end


@interface NSMutableDictionary (Additions)

- (void) setInteger:(NSInteger)i forKey:(id)key;
- (void) setUnsignedInteger:(NSUInteger)i forKey:(id)key;
- (void) setFloat:(Float32)f forKey:(id)key;

@end
