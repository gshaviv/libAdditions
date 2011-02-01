//
//  NSCoderGSA.h
//  AdditionsLib
//
//  Created by Guy Shaviv on 1/2/11.
//  Copyright 2011 LitePoint Corp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSCoder (GSA)
- (void) encodeInt:(NSInteger)i forKey:(NSString*)key;
- (void) encodeFloat:(float)n forKey:(NSString*)key;
- (void) encodeBool:(BOOL)n forKey:(NSString*)key;
- (NSUInteger) decodeUnsignedIntForKey:(NSString*)key default:(NSUInteger)d ;
- (NSInteger) decodeIntForKey:(NSString*)key default:(NSInteger)d;
- (float) decodeFloatForKey:(NSString*)key default:(float)d;
- (BOOL) decodeBoolForKey:(NSString*)key default:(BOOL)d;
@end
