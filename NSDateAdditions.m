//
//  NSDateAdditions.m
//  ilite
//
//  Created by Guy Shaviv on 5/7/09.
//  Copyright 2009 LitePoint Corp.. All rights reserved.
//

#import "NSDateAdditions.h"

static NSDateFormatter *f = nil;

@implementation NSDate (Additions)

+ (id)dateWithString:(NSString *)aString {
	if (f == nil) {
		f = [[NSDateFormatter alloc] init];
		[f setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	}
	NSDate *d = [f dateFromString:aString];
	return d;
}

+ (void) setDateFormat:(NSString*)format {
	if (f == nil) {
		f = [[NSDateFormatter alloc] init];		
	}	
	[f setDateFormat:format];
}

+ (void) setDateFormatTimezone:(NSTimeZone*)timezone {
	if (f == nil) {
		f = [[NSDateFormatter alloc] init];		
	}	
	[f setTimeZone:timezone];
}

- (NSString*) stringValue {
	if (f == nil) {
		f = [[NSDateFormatter alloc] init];		
		[f setDateStyle:NSDateFormatterMediumStyle];
	}	
	return [f stringFromDate:self];
}

@end
