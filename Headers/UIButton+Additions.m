//
//  UIButton+Additions.m
//  AdditionsLib
//
//  Created by Guy Shaviv on 11/3/12.
//  Copyright (c) 2012 LitePoint Corp. All rights reserved.
//

#import "UIButton+Additions.h"
#import "UIViewAdditions.h"

@implementation UIButton (Additions)
- (UIBarButtonItem*) barItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self];
    [self sizeToFit];
    self.height = 38;
    return item;
}
@end
