//
//  UIPopoverControllerSingle.h
//  houzz
//
//  Created by Guy Shaviv on 4/4/10.
//  Copyright 2010 Tiv Studio. All rights reserved.
//  Ensure only one popover is visible
//  License: You can use this source code freely provided you keep this notice any time you distribute this as source.
//           Distribution as binary is permitted. An attribution would be nice but not essential.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIPopoverController (Single)

+ (void) primeCategorySingle;
+ (UIPopoverController*) visibleController;
+ (void) overrideArrowDirection:(UIPopoverArrowDirection)dir;

- (void) oldSetDelegate:(id)d;//internal

@end
