//
//  UIApplicationNetworkActivity.h
//  MobileCompas
//
//  Created by Guy Shaviv on 11/24/09.
//  Copyright 2009 .. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIApplication (NetworkActivity)

+ (void) startNetworkActivity;
+ (void) endNetworkActivity;
+ (void) resetNetworkActivity;

@end
