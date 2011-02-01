#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Additions)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic,readonly) CGFloat right;
@property(nonatomic,readonly) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;

@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;


- (UIScrollView*)findFirstScrollView;

- (UIView*)firstViewOfClass:(Class)cls;

- (UIView*)firstParentOfClass:(Class)cls;

- (UIView*)findChildWithDescendant:(UIView*)descendant;

- (CGPoint)offsetFromView:(UIView*)otherView;

- (void) removeSubviews;

- (NSInteger) indexOfView:(UIView*)view;

- (UIViewController*)viewController; // return the view controller of this view or a parent view
- (void) makeScrollViewGestureRecognizersRequireFail:(UIGestureRecognizer*)toFail; // any parent scrollview will let toFail fail first
- (void) makeScrollViewGestureRecognizersRequireViewToFail:(UIView*)toFail;

@end

#ifdef QUARTZADDITIONS
@interface UIView (QuartzAdditions)
- (UIImage*) renderToImage;
@end
#endif

