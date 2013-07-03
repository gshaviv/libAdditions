
#import <UIKit/UIKit.h>

@interface UIView (Shadow)
- (void)addShadowWithcolor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity  path:(UIBezierPath*)path;
- (void)addShadowWithcolor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;
- (void) addCurvedShadowWithOffset:(CGFloat)offset curve:(CGFloat)curve radius:(CGFloat)radius color:(UIColor*)color opacity:(CGFloat)opacity;
- (void)updateShadowPath;
- (void) addCurvedShadowWithRightOffset:(CGFloat)offsetR leftOffsset:(CGFloat)offsetL curve:(CGFloat)curve radius:(CGFloat)radius color:(UIColor*)color opacity:(CGFloat)opacity;

- (void)removeShadow;
- (void)restoreShadow;

- (void)animateShadowFrom:(CGRect)fromValue to:(CGRect)toValue duration:(CGFloat)duration;

@end
