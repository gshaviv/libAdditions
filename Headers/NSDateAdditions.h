//
//  NSDateAdditions.h
//  ilite
//
//  Created by Guy Shaviv on 5/7/09.
//  Copyright 2009 LitePoint Corp.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (Additions) 

 /* Creates and returns an NSDate object with a date and time value specified by a given string in the 
  international string representation format (YYYY-MM-DD HH:MM:SS ±HHMM). */
+ (id)dateWithString:(NSString *)aString;
+ (void) setDateFormat:(NSString*)format;
+ (void) setDateFormatTimezone:(NSTimeZone*)timezone;
- (NSString*) stringValue;
@end
