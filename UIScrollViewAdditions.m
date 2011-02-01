//
//  UIScrollViewAdditions.m
//  houzz
//
//  Created by Guy Shaviv on 22/5/10.
//  Copyright 2010 Tiv Studio. All rights reserved.
//

#import "UIScrollViewAdditions.h"


@implementation UIScrollView (Additions)

- (CGRect) visibleRect {
	CGRect visibleRect;
	visibleRect.origin = self.contentOffset;
	visibleRect.size = self.bounds.size;
	
	float theScale = 1.0 / self.zoomScale;
	visibleRect.origin.x *= theScale;
	visibleRect.origin.y *= theScale;
	visibleRect.size.width *= theScale;
	visibleRect.size.height *= theScale;
	return visibleRect;
}

- (void) makeGestureRecognizersRequireFail:(UIGestureRecognizer*)first {
	for (UIGestureRecognizer *rec in self.gestureRecognizers) {
		[rec requireGestureRecognizerToFail:first];
	}
}
@end
