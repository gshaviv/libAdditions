/*
 *  CGGeometryAdditions.h
 *  houzz
 *
 *  Created by Guy Shaviv on 15/3/10.
 *  Copyright 2010 . All rights reserved.
 *
 */
#import <UIKit/UIKit.h>

static inline  CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size) {
	return CGRectMake(center.x - size.width/2., center.y - size.height/2., size.width, size.height);
}

static inline  CGRect CGRectMakeWithCxCyWH(float cx, float cy, float width, float height) {
	return CGRectMake(cx - width/2., cy - height/2., width, height);
}

static inline CGPoint CGPointDiff(CGPoint p1, CGPoint p0) {
	return CGPointMake(p1.x-p0.x, p1.y-p0.y);
}

static inline NSRange NSRangeMake(float location, float length) {
    NSRange range;
    range.location = location;
    range.length = length;
    return range;
}

static inline NSRange NSRangeMakeFromStartToEnd(float start, float end) {
    NSRange range;
    range.location = start;
    range.length = end - start;
    return range;
}