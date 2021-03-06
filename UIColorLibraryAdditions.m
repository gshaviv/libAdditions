//
//  UIColorLibraryAdditions.m
//  AdditionsLib
//
//  Created by Guy Shaviv on 16/10/10.
//  Copyright 2010 LitePoint Corp. All rights reserved.
//

#import "UIColorLibraryAdditions.h"


@implementation UIColor (LibraryAdditions)

+ (UIColor*) colorWithWebColor:(unsigned long)color andAlpha:(float)alpha {
	float red = ((color>>16) & 0xFF) / 255.;
	float green = ((color>>8) & 0xff) / 255.;
	float blue = (color & 0xff) / 255.;
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (float) grayLevel {
    CGFloat red,green,blue,alpha;
    if ([self getRed:&red green:&green blue:&blue alpha:&alpha]) {
        return red*.3+green*.59+blue*.11;
    } else {
        [self getWhite:&red alpha:&alpha];
        return red;
    }
}

@end
