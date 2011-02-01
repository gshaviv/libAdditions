//
//  UIViewAdditions.m
//  Weather.IL
//
//  Created by Guy Shaviv on 28/3/09.
//  Copyright 2009 .. All rights reserved.
//

#import "UIViewAdditions.h"
#import "UIScrollViewAdditions.h"

@implementation UIView (Additions)

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGFloat)screenX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
	}
	return x;
}

- (CGFloat)screenY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
	}
	return y;
}

- (CGFloat)screenViewX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			x -= scrollView.contentOffset.x;
		}
	}
	
	return x;
}

- (CGFloat)screenViewY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			y -= scrollView.contentOffset.y;
		}
	}
	return y;
}

- (CGPoint)offsetFromView:(UIView*)otherView {
	CGFloat x = 0, y = 0;
	for (UIView* view = self; view && view != otherView; view = view.superview) {
		x += view.left;
		y += view.top;
	}
	return CGPointMake(x, y);
}




- (UIScrollView*)findFirstScrollView {
	if ([self isKindOfClass:[UIScrollView class]])
		return (UIScrollView*)self;
	
	for (UIView* child in self.subviews) {
		UIScrollView* it = [child findFirstScrollView];
		if (it)
			return it;
	}
	
	return nil;
}

- (UIView*)firstViewOfClass:(Class)cls {
	if ([self isKindOfClass:cls])
		return self;
	
	for (UIView* child in self.subviews) {
		UIView* it = [child firstViewOfClass:cls];
		if (it)
			return it;
	}
	
	return nil;
}

- (UIView*)firstParentOfClass:(Class)cls {
	if ([self isKindOfClass:cls]) {
		return self;
	} else if (self.superview) {
		return [self.superview firstParentOfClass:cls];
	} else {
		return nil;
	}
}

- (UIView*)findChildWithDescendant:(UIView*)descendant {
	for (UIView* view = descendant; view && view != self; view = view.superview) {
		if (view.superview == self) {
			return view;
		}
	}
	
	return nil;
}

- (void) removeSubviews {
	[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (NSInteger) indexOfView:(UIView*)view {
	NSArray *subviews = self.subviews;
	for (int i=0;i<subviews.count;i++) {
		if ([[subviews objectAtIndex:i] isEqual:view]) {
			return i;
		}
	}
	return -1;
}

- (UIViewController*)viewController {
	for (UIView* next = self; next; next = next.superview) {
		UIResponder* nextResponder = [next nextResponder];
		if ([nextResponder isKindOfClass:[UIViewController class]]) {
			return (UIViewController*)nextResponder;
		}
	}
	return nil;
}

- (void) makeScrollViewGestureRecognizersRequireFail:(UIGestureRecognizer*)toFail {
	if ([self isKindOfClass:[UIScrollView class]]) {
		[(UIScrollView*)self makeGestureRecognizersRequireFail:toFail];
	}
	
	for (UIView *item in self.subviews) {
		[item makeScrollViewGestureRecognizersRequireFail:toFail];
	}
}

- (void) makeScrollViewGestureRecognizersRequireViewToFail:(UIView*)toFail {
	if ([self isKindOfClass:[UIScrollView class]]) {
		for (UIGestureRecognizer *rec in toFail.gestureRecognizers)
			[(UIScrollView*)self makeGestureRecognizersRequireFail:rec];
	}
	for (UIView *item in self.subviews) {
		[item makeScrollViewGestureRecognizersRequireViewToFail:toFail];
	}
}




@end

#ifdef QUARTZADDITIONS
#import <QuartzCore/QuartzCore.h>
@implementation UIView (QuartzAdditions)

- (UIImage*) renderToImage {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return viewImage;
}
@end
#endif


