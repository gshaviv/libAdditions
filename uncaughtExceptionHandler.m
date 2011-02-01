/*
 *  uncaughtExceptionHandler.c
 *  AdditionsLib
 *
 *  Created by Guy Shaviv on 28/7/10.
 *  Copyright 2010 LitePoint Corp. All rights reserved.
 *
 */

#include "uncaughtExceptionHandler.h"

#import "GTMStackTrace.h"

@interface placeholder 
+ (void)logError:(NSString *)errorID message:(NSString *)message exception:(NSException *)exception;
@end


void uncaughtExceptionHandler(NSException *exception) {
	NSString *fullBacktrace = GTMStackTraceFromException(exception);
    @try {
        NSMutableString *backtrace = [NSMutableString stringWithUTF8String:""];
        NSArray *backtraceArray = [fullBacktrace componentsSeparatedByString:@"\n"];
        
        for (id entry in backtraceArray) {
			NSRange testRange = [entry rangeOfString:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]];
			NSRange start = [entry rangeOfString:@"start()"];
			NSRange main = [entry rangeOfString:@"main()"];
            if (testRange.length && !start.length && !main.length) {
                NSRange chompRange = [entry rangeOfString:@"0x"];
                if (chompRange.location) {
					NSRange nRange;
					nRange.location = 0;
					nRange.length = 4;
					[backtrace appendString:[entry substringWithRange:nRange]];
                    [backtrace appendString:[entry substringFromIndex:chompRange.location + 10]];
					[backtrace appendString:@" "];
                }
            }
        }
		Class flurry = NSClassFromString(@"FlurryAPI");
		if (flurry) {
			[flurry logError:@"Crash"
						message:[NSString stringWithFormat:@"%@", backtrace ? backtrace : @"no matching backtrace"]
					  exception:exception];			
			NSLog(@"reported error: %@",[NSString stringWithFormat:@"%@", backtrace ? backtrace : @"no matching backtrace"]);
		}
    }
    @catch (NSException *exception) {
        NSLog(@"whoa!  could not handle uncaught exception! %@",fullBacktrace);
    }
}
