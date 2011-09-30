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
    @autoreleasepool {
	NSString *fullBacktrace = GTMStackTraceFromException(exception);
	NSSetUncaughtExceptionHandler(NULL);
	signal(SIGABRT, SIG_DFL);
	signal(SIGILL, SIG_DFL);
	signal(SIGSEGV, SIG_DFL);
	signal(SIGFPE, SIG_DFL);
	signal(SIGBUS, SIG_DFL);
	signal(SIGPIPE, SIG_DFL);
    @try {
        NSMutableString *backtrace = [NSMutableString stringWithUTF8String:""];
        NSArray *backtraceArray = [fullBacktrace componentsSeparatedByString:@"\n"];
        NSLog(@"Exception:\n%@",fullBacktrace);
        
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
		}
    }
    @catch (NSException *exception) {
        NSLog(@"whoa!  could not handle uncaught exception! %@",fullBacktrace);
    }
    }
}

static void SignalHandler(int signalNo)
{
    @autoreleasepool {
    NSString *fullBacktrace = GTMStackTrace();
	NSSetUncaughtExceptionHandler(NULL);
	signal(SIGABRT, SIG_DFL);
	signal(SIGILL, SIG_DFL);
	signal(SIGSEGV, SIG_DFL);
	signal(SIGFPE, SIG_DFL);
	signal(SIGBUS, SIG_DFL);
	signal(SIGPIPE, SIG_DFL);
    @try {
        NSMutableString *backtrace = [NSMutableString stringWithUTF8String:""];
        NSArray *backtraceArray = [fullBacktrace componentsSeparatedByString:@"\n"];
        NSLog(@"Signal %d:\n%@",signalNo,fullBacktrace);
     
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
            NSException *exception = [NSException exceptionWithName:@"Signal" 
                                                             reason:[NSString stringWithFormat:@"%d",signalNo]
                                                           userInfo:[NSDictionary
                                                                     dictionaryWithObject:[NSNumber numberWithInt:signalNo]
                                                                     forKey:@"SIGNAL"]];
			[flurry logError:@"Signal"
                     message:[NSString stringWithFormat:@"%@", backtrace ? backtrace : @"no matching backtrace"]
                   exception:exception];			
		}
    }
    @catch (NSException *exception) {
        NSLog(@"whoa!  could not handle uncaught exception! %@",fullBacktrace);
    }
    }
}

void InstallUncaughtExceptionHandler(void)
{
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
	signal(SIGABRT, SignalHandler);
	signal(SIGILL, SignalHandler);
	signal(SIGSEGV, SignalHandler);
	signal(SIGFPE, SignalHandler);
	signal(SIGBUS, SignalHandler);
	signal(SIGPIPE, SignalHandler);
}
