#import <QuartzCore/QuartzCore.h>

#import "UIView+Shadow.h"
#import <objc/runtime.h>

@implementation UIView (Shadow)

static char COLOR_KEY;
static char OPACITY_KEY;

- (void)addShadowWithcolor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity {
    [self addShadowWithcolor:color offset:offset radius:radius opacity:opacity path:[UIBezierPath bezierPathWithRect:self.bounds]];
}

- (void)addShadowWithcolor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity  path:(UIBezierPath*)path {
	CGPathRef shadowPath = [path CGPath];

	[self.layer setShadowColor:color.CGColor];
	[self.layer setShadowOffset:offset];
	[self.layer setShadowRadius:radius];
	[self.layer setShadowOpacity:opacity];
	[self.layer setShadowPath:shadowPath];

	objc_setAssociatedObject(self, &COLOR_KEY, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, &OPACITY_KEY, @(opacity), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)updateShadowPath {
	CGMutablePathRef shadowPath = CGPathCreateMutable();
	CGPathAddRect(shadowPath, NULL, [self bounds]);
	[self.layer setShadowPath:shadowPath];
	CFRelease(shadowPath);
}

- (void)removeShadow {
	[self.layer setShadowColor:0];
	[self.layer setShadowOpacity:0];
	[self.layer setShadowPath:NULL];
}

- (void)restoreShadow {
	
	CGMutablePathRef shadowPath = CGPathCreateMutable();
	CGPathAddRect(shadowPath, NULL, [self bounds]);
	
	UIColor *lastUsedColor = objc_getAssociatedObject(self, &COLOR_KEY);
	CGFloat lastUsedOpacity = [(NSNumber *)objc_getAssociatedObject(self, &OPACITY_KEY) floatValue]; 
	
	[self.layer setShadowColor:lastUsedColor.CGColor];
	[self.layer setShadowOpacity:lastUsedOpacity];
	[self.layer setShadowPath:shadowPath];
	CFRelease(shadowPath);
}

- (void)animateShadowFrom:(CGRect)fromValue to:(CGRect)toValue duration:(CGFloat)duration {

	CGMutablePathRef oldShadowPath = CGPathCreateMutable();
	CGPathAddRect(oldShadowPath, NULL/*transform*/, fromValue);	
	
	CGMutablePathRef newShadowPath = CGPathCreateMutable();
	CGPathAddRect(newShadowPath, NULL/*transform*/, toValue);
	
	CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
	
	shadowAnimation.fromValue = (__bridge id)oldShadowPath;	
	shadowAnimation.toValue = (__bridge id)newShadowPath;
	
	CFRelease(oldShadowPath);

	shadowAnimation.duration = duration;
	shadowAnimation.autoreverses = NO;
	shadowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	shadowAnimation.removedOnCompletion = NO;
	shadowAnimation.fillMode = kCAFillModeForwards;
	
	[self setValue:(__bridge id)newShadowPath forKeyPath:@"shadowPath"];	
	[self.layer addAnimation:shadowAnimation forKey:@"shadowPath"];
	
	CFRelease(newShadowPath);
}

@end
