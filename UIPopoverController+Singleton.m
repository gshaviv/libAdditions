//
//  UIPopoverControllerSingle.m
//  houzz
//
//  Created by Guy Shaviv on 4/4/10.
//  Copyright 2010 Tiv Studio. All rights reserved.
//
//  License: You can use this source code freely provided you keep this notice any time you distribute this as source.
//           Distribution as binary is permitted. An attribution would be nice but not essential.

#import "UIPopoverController+Singleton.h"

static UIPopoverController *visibleController;


@implementation PopoverController

+ (void) presentPopover:(UIPopoverController*)popoverController fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
    [popoverController presentPopoverFromBarButtonItem:item permittedArrowDirections:arrowDirections animated:animated];
    visibleController = popoverController;
}

+ (void) presentPopover:(UIPopoverController*)popoverController fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
    [popoverController presentPopoverFromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
    visibleController = popoverController;
}

+ (UIPopoverController*) visibleController {
    if (visibleController && [visibleController isPopoverVisible]) {
        return visibleController;
    } else {
        visibleController = nil;
    }
    return nil;
}

@end
