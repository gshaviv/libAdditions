/*
 *  CGGeometryAdditions.h
 *  houzz
 *
 *  Created by Guy Shaviv on 15/3/10.
 *  Copyright 2010 . All rights reserved.
 *
 */
#import <UIKit/UIKit.h>
#import <math.h>

static inline  CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size) {
	return CGRectMake(center.x - size.width/2., center.y - size.height/2., size.width, size.height);
}

static inline  CGRect CGRectMakeWithCxCyWH(float cx, float cy, float width, float height) {
	return CGRectMake(cx - width/2., cy - height/2., width, height);
}

static inline CGPoint CGPointDiff(CGPoint p1, CGPoint p0) {
	return CGPointMake(p1.x-p0.x, p1.y-p0.y);
}

#define NSRangeMake(loc,len) NSMakeRange(loc,len)

static inline NSRange NSRangeMakeFromStartToEnd(NSUInteger start, NSUInteger end) {
    NSRange range;
    range.location = start;
    range.length = end - start;
    return range;
}

static inline float distanceBetweenPoints(CGPoint p1, CGPoint p2) {
    float x = p1.x - p2.x;
    float y = p1.y - p2.y;
    return sqrtf(x * x + y * y);
}

static inline CGPoint CGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect),CGRectGetMidY(rect));
}

CGSize sizeThatFitsKeepingAspectRatio(CGSize originalSize, CGSize sizeToFit);

static inline CGPoint CGRectCenter(CGRect rect) {
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}


#define NSRangeEnd(r) (r.location + r.length)