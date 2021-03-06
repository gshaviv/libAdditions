//
//  UIApplicationNetworkActivity.m
//  MobileCompas
//
//  Created by Guy Shaviv on 11/24/09.
//  Copyright 2009 .. All rights reserved.
//

#import "UIApplicationNetworkActivity.h"

static int level = 0;

@implementation UIApplication (NetworkActivity)

+ (void) startNetworkActivity {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (++level == 1) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    });
}

+ (void) endNetworkActivity {
    dispatch_async(dispatch_get_main_queue(), ^{
	if (--level < 0) level = 0;
	if (level == 0) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;		
	}
    });
}

+ (void) resetNetworkActivity {
	level = 0;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
