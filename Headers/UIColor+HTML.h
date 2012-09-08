#import <UIKit/UIKit.h>

@interface UIColor (HTML)
+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *)colorWithHTMLName:(NSString *)name;
- (NSString *)htmlHexString;
- (CGFloat)alphaComponent;
@end



