//
//  UIButton+Additions.h
//  AdditionsLib
//
//  Created by Guy Shaviv on 11/3/12.
//  Copyright (c) 2012 LitePoint Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(id sender);

@interface UIButton (Additions)
- (UIBarButtonItem*) barItem;
- (void) onEvent:(UIControlEvents)event performBlock:(ActionBlock)block;

@end
