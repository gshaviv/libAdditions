//
//  UIPopoverControllerSingle.m
//  houzz
//
//  Created by Guy Shaviv on 4/4/10.
//  Copyright 2010 Tiv Studio. All rights reserved.
//
//  License: You can use this source code freely provided you keep this notice any time you distribute this as source.
//           Distribution as binary is permitted. An attribution would be nice but not essential.

#import "UIPopoverControllerSingle.h"
#import "Swizzle.h"

static UIPopoverController *visibleController;
static NSMutableSet *proxies = 0;

@interface ProxyDelegate : NSObject <UIPopoverControllerDelegate>
{
	id<UIPopoverControllerDelegate> delegate;
}

@property (nonatomic,assign) id<UIPopoverControllerDelegate> delegate;

@end

@implementation ProxyDelegate

@synthesize delegate;

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
	if ([delegate respondsToSelector:@selector(popoverControllerShouldDismissPopover:)])
		return [delegate popoverControllerShouldDismissPopover:popoverController];
	return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
	visibleController = nil;
	[self autorelease];
	[popoverController oldSetDelegate:self.delegate];
	if ([delegate respondsToSelector:@selector(popoverControllerDidDismissPopover:)]) {
		[delegate popoverControllerDidDismissPopover:popoverController];
	}
}

@end



@implementation UIPopoverController (Single)

- (void) oldSetDelegate:(id)d {
	if ([self.delegate isKindOfClass:[ProxyDelegate class]]) {
		((ProxyDelegate*)self.delegate).delegate = d;
	} else {
		[self oldSetDelegate:d];
	}
}

- (void)oldDismissPopoverAnimated:(BOOL)animated {
	if (visibleController) {
		if ([self.delegate isKindOfClass:[ProxyDelegate class]]) {
			[proxies removeObject:self.delegate];
			[self oldSetDelegate:((ProxyDelegate*)self.delegate).delegate];
		}	
	}
	[self oldDismissPopoverAnimated:(BOOL)animated];
	visibleController = nil;
}



+ (UIPopoverController*) visibleController {
	return visibleController;
}

- (void) presenting {
	if (visibleController && visibleController != self) {
		UIPopoverController *old = visibleController;
		if ([visibleController.delegate respondsToSelector:@selector(popoverControllerDidDismissPopover:)]) {
			[visibleController.delegate popoverControllerDidDismissPopover:visibleController];
		}
		[old dismissPopoverAnimated:YES];
	}
	visibleController = self;
	if (![self.delegate isKindOfClass:[ProxyDelegate class]]) {
		ProxyDelegate *proxy = [[ProxyDelegate new] autorelease];
		proxy.delegate = self.delegate;
		[self oldSetDelegate:proxy];
        if (!proxies) {
            proxies = [[NSMutableSet set] retain];
        }
        [proxies addObject:proxy];
	} 
}

// not needed, calls present from rect
//- (void)oldPresentPopoverFromBarButtonItem:(UIBarButtonItem *)item 
//			   permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections 
//							   animated:(BOOL)animated {
//	[self presenting];
//	[self oldPresentPopoverFromBarButtonItem:item permittedArrowDirections:arrowDirections animated:animated];
//}

static UIPopoverArrowDirection overrideArrowDirection = UIPopoverArrowDirectionUnknown;

- (void)oldPresentPopoverFromRect:(CGRect)rect 
						inView:(UIView *)view 
	  permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections 
					  animated:(BOOL)animated {
	[self presenting];
	if (overrideArrowDirection != UIPopoverArrowDirectionUnknown) {
		arrowDirections = overrideArrowDirection;
		overrideArrowDirection = UIPopoverArrowDirectionUnknown;
	}
	[self oldPresentPopoverFromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
}

+ (void) overrideArrowDirection:(UIPopoverArrowDirection)dir {
	overrideArrowDirection = dir;
}

+ (void) primeCategorySingle {
	Swizzle([UIPopoverController class],@selector(dismissPopoverAnimated:),@selector(oldDismissPopoverAnimated:));
//	Swizzle([UIPopoverController class],@selector(presentPopoverFromBarButtonItem:permittedArrowDirections:animated:),
//			@selector(oldPresentPopoverFromBarButtonItem:permittedArrowDirections:animated:));
	Swizzle([UIPopoverController class],@selector(presentPopoverFromRect:inView:permittedArrowDirections:animated:),
			@selector(oldPresentPopoverFromRect:inView:permittedArrowDirections:animated:));
	Swizzle([UIPopoverController class], @selector(setDelegate:), @selector(oldSetDelegate:));
}
@end
