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
		[f setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss' Z'"];
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

- (NSString*) relativeTimeString {
    NSTimeInterval diff = -[self timeIntervalSinceNow];
    if (diff < 60.) {
        return NSLocalizedString(@"Just now", );
    } else if (diff < 120.) {
        return NSLocalizedString(@"A minute ago",);
    } else if (diff < 60.*60.) {
        return [NSString stringWithFormat:@"%.0f Minutes ago",diff/60.];
    } else if (diff < 120.*60.) {
        return NSLocalizedString(@"An hour ago", );
    } else if (diff < 86400.) {
        return [NSString stringWithFormat:@"%.0f Hours ago",diff/3600.];
    } else if (diff < 172800.) {
        return NSLocalizedString(@"Yesterday", );
    } else if (diff < 86400.*30) {
        return [NSString stringWithFormat:@"%.0f Days ago",diff/86400.];
    } else {
        if (!f) {
            f = [NSDateFormatter new];
            [f setTimeStyle:NSDateFormatterNoStyle];
            [f setDateStyle:NSDateFormatterMediumStyle];
        }
        return [f stringFromDate:self];
    }
}

@end
