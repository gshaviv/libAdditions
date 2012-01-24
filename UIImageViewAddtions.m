//
//  UIImageViewAddtions.m
//  HotVOD
//
//  Created by Guy Shaviv on 12/23/09.
//  Copyright 2009 .. All rights reserved.
//

#import "UIImageViewAddtions.h"


@implementation UIImageView (additions)

+ (UIImageView *) imageViewWithImageNamed:(NSString *)name {
	UIImage *image = [UIImage imageNamed:name];
	return [[UIImageView alloc] initWithImage:image];
}

+ (UIImageView *) imageViewWithImage:(UIImage*)image {
	return [[UIImageView alloc] initWithImage:image] ;
}

@end
