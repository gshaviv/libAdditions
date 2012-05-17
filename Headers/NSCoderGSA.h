//
//  NSCoderGSA.h
//  AdditionsLib
//
//  Created by Guy Shaviv on 1/2/11.
//  Copyright 2011 LitePoint Corp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSCoder (GSA)
- (void) encodeIntNumber:(NSInteger)i forKey:(NSString*)key;
- (void) encodeFloatNumber:(float)n forKey:(NSString*)key;
- (void) encodeBoolNumber:(BOOL)n forKey:(NSString*)key;

- (NSUInteger) decodeUnsignedIntNumberForKey:(NSString*)key default:(NSUInteger)d ;
- (NSInteger) decodeIntNumberForKey:(NSString*)key default:(NSInteger)d;
- (float) decodeFloatNumberForKey:(NSString*)key default:(float)d;
- (BOOL) decodeBoolNumberForKey:(NSString*)key default:(BOOL)d;
@end
