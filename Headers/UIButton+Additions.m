//
//  UIButton+Additions.m
//  AdditionsLib
//
//  Created by Guy Shaviv on 11/3/12.
//  Copyright (c) 2012 LitePoint Corp. All rights reserved.
//

#import "UIButton+Additions.h"
#import "UIViewAdditions.h"
#import "NSObject+AttachObject.h"

static const char *touchUpInside = 0;


@implementation UIButton (Additions)
- (UIBarButtonItem*) barItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self];
    [self sizeToFit];
    self.width += self.imageEdgeInsets.left + self.imageEdgeInsets.right + self.titleEdgeInsets.left + self.titleEdgeInsets.right;// bug, size to fit doesn't consider insets for some reason
    if (self.width < 38) self.width = 38;
    self.height = 40;
    return item;
}

- (void) setStretchable:(BOOL)dummy {
    for (NSNumber *state in @[@(UIControlStateNormal),@(UIControlStateDisabled),@(UIControlStateHighlighted),@(UIControlStateSelected)]) {
        UIImage *bg = [self backgroundImageForState:[state unsignedIntegerValue]];
        if (bg && [bg isMemberOfClass:[UIImage class]]) {
            CGSize sz = bg.size;
            CGFloat xCap = floorf(sz.width/2.-.1);
            CGFloat yCap = floorf(sz.height/2.-.1);
            bg = [bg resizableImageWithCapInsets:UIEdgeInsetsMake(yCap, xCap, yCap, xCap)];
            [self setBackgroundImage:bg forState:[state unsignedIntegerValue]];
        } else if ([state unsignedIntegerValue] == UIControlStateNormal) {
            break;
        }
    }
}

- (void) onEvent:(UIControlEvents)event performBlock:(ActionBlock)block {
    switch (event) {
        case UIControlEventTouchUpInside:
            [self setAssociatedObject:block forKey:touchUpInside policy:AssociationPolicyCopy];
            [self addTarget:self action:@selector(didTouchUpInside) forControlEvents:event];
            break;

        default:
            NSAssert(NO, @"Event not implemented yet");
            break;
    }
}

- (void) didTouchUpInside {
    ActionBlock block = [self associatedObjectForKey:touchUpInside];
    block(self);
}
@end
