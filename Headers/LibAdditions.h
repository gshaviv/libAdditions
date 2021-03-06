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
#import "NSMutableArrayStack.h"
#import "NSNotificationCenterAdditions.h"
#import "UIViewAdditions.h"
#import "UIScrollViewAdditions.h"
#import "UIDevice-hardware.h"
#import "UIApplicationNetworkActivity.h"
#import "NSStringAdditions.h"
#import "UIImageAdditions.h"
#import "UIImageViewAddtions.h"
#import "UIColorLibraryAdditions.h"
#import "dispatchShortcuts.h"
#import "NSCoderGSA.h"
#import "ObjectToDictionary.h"
#import "UIButton+Additions.h"
#import "BlockAlertView.h"
#import "BlockActionSheet.h"
#import "UIColor+HTML.h"
#import "UIView+Shadow.h"
#import "NSObject+AttachObject.h"
#import "UIColor+CrossFade.h"
#import "NSObject+AttachObject.h"

#define DocumentsDirectory ((NSString*)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0])
#define LibraryDirectory [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define CacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
