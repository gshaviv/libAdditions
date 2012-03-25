//
//  UIColorLibraryAdditions.h
//  AdditionsLib
//
//  Created by Guy Shaviv on 16/10/10.
//  Copyright 2010 LitePoint Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (LibraryAdditions)
+ (UIColor*) colorWithWebColor:(unsigned long)color andAlpha:(float)alpha;
- (float) grayLevel;
@end
