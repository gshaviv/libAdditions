//
//  LibraryAdditions.h
//  AdditionsLib
//
//  Created by Guy Shaviv on 23/7/10.
//  Copyright (c) 2010 LitePoint Corp. All rights reserved.
//

#import "Alert.h"
#import "CGGeometryAdditions.h"
#import "NSDateAdditions.h"
#import "NSDictionaryAdditions.h"
#import "NSInvocation(ForwardedConstruction).h"
#import "NSMutableArrayStack.h"
#import "NSNotificationCenterAdditions.h"
#import "UIViewAdditions.h"
#import "UIScrollViewAdditions.h"
#import "UIDevice-hardware.h"
#import "Swizzle.h"
#import "UIApplicationNetworkActivity.h"
#import "NSStringAdditions.h"
#import "UIImageAdditions.h"
#import "UIImageViewAddtions.h"
#import "uncaughtExceptionHandler.h"
#import "UIColorLibraryAdditions.h"
#import "dispatchShortcuts.h"
#import "NSCoderGSA.h"

#define DocumentsDirectory ((NSString*)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0])
#define LibraryDirectory [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
