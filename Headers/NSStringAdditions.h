//
//  NSStringAdditions.h
//  HotVOD
//
//  Created by Guy Shaviv on 12/31/09.
//  Copyright 2009 .. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Additions)

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query ;
- (NSDictionary*)dictionaryFromQueryUsingEncoding: (NSStringEncoding)encoding;
- (int) hexValue;
+ (NSString *)globalUniqueIdentifier;
- (NSString *)stringByEscapingToURLSafe;
- (NSString*) stringByStrippingHTMLTags;
@property (nonatomic, readonly) NSRange entireStringRange;
@end
