//
//  BlockActionSheet.m
//  AdditionsLib
//
//  Created by Guy Shaviv on 6/20/12.
//  Copyright (c) 2012 LitePoint Corp. All rights reserved.
//

#import "BlockActionSheet.h"

@interface BlockActionSheet ()
@property (nonatomic, copy) void (^actionButtonHit)(int) ;
@end

@implementation BlockActionSheet
@synthesize actionButtonHit;

- (void) showFromToolbar: (UIToolbar *) view buttonBlock: (actionViewButtonHit) block {
	self.actionButtonHit = block;
	self.delegate = self;
	[super showFromToolbar: view];
}

- (void) showFromTabBar: (UITabBar *) view buttonBlock: (actionViewButtonHit) block {
	self.actionButtonHit = block;
	self.delegate = self;
	[super showFromTabBar: view];
}

- (void) showFromBarButtonItem: (UIBarButtonItem *) item animated: (BOOL) animated buttonBlock: (actionViewButtonHit) block {
	self.actionButtonHit = block;
	self.delegate = self;
	[super showFromBarButtonItem: item animated: animated];
}

- (void) showFromRect: (CGRect) rect inView: (UIView *) view animated: (BOOL) animated buttonBlock: (actionViewButtonHit) block {
	self.actionButtonHit = block;
	self.delegate = self;
	[super showFromRect: rect inView: view animated: animated];
}
- (void) showInView: (UIView *) view buttonBlock: (actionViewButtonHit) block {
	self.actionButtonHit = block;
	self.delegate = self;
	[super showInView: view];
}


- (void) actionSheet: (UIActionSheet *) actionSheet clickedButtonAtIndex: (NSInteger) buttonIndex {
	if (self.actionButtonHit) self.actionButtonHit(buttonIndex);
}

@end
