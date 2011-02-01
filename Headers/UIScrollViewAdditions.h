//
//  UIScrollViewAdditions.h
//  houzz
//
//  Created by Guy Shaviv on 22/5/10.
//  Copyright 2010 Tiv Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIScrollView (Additions)

- (CGRect) visibleRect;
- (void) makeGestureRecognizersRequireFail:(UIGestureRecognizer*)first;

@end
