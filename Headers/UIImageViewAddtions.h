//
//  UIImageViewAddtions.h
//  HotVOD
//
//  Created by Guy Shaviv on 12/23/09.
//  Copyright 2009 .. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (additions)

+ (UIImageView *) imageViewWithImageNamed:(NSString *)name;
+ (UIImageView *) imageViewWithImage:(UIImage*)image;
@end
