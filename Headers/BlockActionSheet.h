//
//  BlockActionSheet.h
//  AdditionsLib
//
//  Created by Guy Shaviv on 6/20/12.
//  Copyright (c) 2012 LitePoint Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^actionViewButtonHit)(int buttonIndex);

@interface BlockActionSheet : UIActionSheet <UIActionSheetDelegate>
@property (nonatomic, copy) actionViewButtonHit actionButtonHit;

- (void) showFromToolbar: (UIToolbar *) view buttonBlock: (actionViewButtonHit) block;
- (void) showFromTabBar: (UITabBar *) view buttonBlock: (actionViewButtonHit) block;
- (void) showFromBarButtonItem: (UIBarButtonItem *) item animated: (BOOL) animated buttonBlock: (actionViewButtonHit) block;
- (void) showFromRect: (CGRect) rect inView: (UIView *) view animated: (BOOL) animated buttonBlock: (actionViewButtonHit) block;
- (void) showInView: (UIView *) view buttonBlock: (actionViewButtonHit) block;
@end
