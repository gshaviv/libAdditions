/*
 *  uncaughtExceptionHandler.c
 *  AdditionsLib
 *
 *  Created by Guy Shaviv on 28/7/10.
 *  Copyright 2010 LitePoint Corp. All rights reserved.
 *
 */

#include "uncaughtExceptionHandler.h"
#import <Foundation/Foundation.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import "GTMStackTrace.h"

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;


@interface placeholder 
+ (void)logError:(NSString *)errorID message:(NSString *)message exception:(NSException *)exception;
@end

NSArray *stackTrace()
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = 0;i < frames;i++) {
	 	[backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;
}


void uncaughtExceptionHandler(NSException *exception) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
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
        NSLog(@"!*!* Exception %@:\n%@",exception,fullBacktrace);
        fflush(stderr);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"_crash"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
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
    [pool release];
    exit(2);
}

void SignalHandler(int signalNo)
{
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    NSString *fullBacktrace = GTMStackTrace();
	NSSetUncaughtExceptionHandler(NULL);
	signal(SIGABRT, SIG_DFL);
	signal(SIGILL, SIG_DFL);
	signal(SIGSEGV, SIG_DFL);
	signal(SIGFPE, SIG_DFL);
	signal(SIGBUS, SIG_DFL);
	signal(SIGPIPE, SIG_DFL);

//    NSMutableString *backtrace = [NSMutableString stringWithUTF8String:""];
//    NSArray *backtraceArray = [fullBacktrace componentsSeparatedByString:@"\n"];
    NSLog(@"!*!* Signal %d:\n%@",signalNo,fullBacktrace);
    fflush(stderr);
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"_crash"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    for (id entry in backtraceArray) {
//        NSRange testRange = [entry rangeOfString:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]];
//        NSRange start = [entry rangeOfString:@"start()"];
//        NSRange main = [entry rangeOfString:@"main()"];
//        if (testRange.length && !start.length && !main.length) {
//            NSRange chompRange = [entry rangeOfString:@"0x"];
//            if (chompRange.location) {
//                NSRange nRange;
//                nRange.location = 0;
//                nRange.length = 4;
//                [backtrace appendString:[entry substringWithRange:nRange]];
//                [backtrace appendString:[entry substringFromIndex:chompRange.location + 10]];
//                [backtrace appendString:@" "];
//            }
//        }
//    }
//		Class flurry = NSClassFromString(@"FlurryAPI");
//		if (flurry) {
//            NSException *exception = [NSException exceptionWithName:@"Signal" 
//                                                             reason:[NSString stringWithFormat:@"%d",signalNo]
//                                                           userInfo:[NSDictionary
//                                                                     dictionaryWithObject:[NSNumber numberWithInt:signalNo]
//                                                                     forKey:@"SIGNAL"]];
////			[flurry logError:@"Signal"
////                     message:[NSString stringWithFormat:@"%@", backtrace ? backtrace : @"no matching backtrace"]
////                   exception:exception];			
//		}

    [pool release];
}

void InstallUncaughtExceptionHandler()
{
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
	signal(SIGABRT, SignalHandler);
	signal(SIGILL, SignalHandler);
	signal(SIGSEGV, SignalHandler);
	signal(SIGFPE, SignalHandler);
	signal(SIGBUS, SignalHandler);
	signal(SIGPIPE, SignalHandler);
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"_crash"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

BOOL DidLastSessionCrash() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"_crash"];
}
