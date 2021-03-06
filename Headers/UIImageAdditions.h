#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (TTCategory)

/*
 * Resizes and/or rotates an image.
 */
//- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate;

// an autorealeased scaled image
- (UIImage*)imageWithWidth:(CGFloat)width height:(CGFloat)height; 
- (UIImage*) imageThatFitsDimension:(CGFloat)maxDim;
- (UIImage*)imageWithSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;


/**
 * Draws the image using content mode rules.
 */
- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode;

/**
 * Draws the image as a rounded rectangle.
 */
- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius;
- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode;

// image loading shortcuts
+ (UIImage*) imageWithFileInBundle:(NSString*)file;
+ (UIImage*) imageWithContentsOfUrl:(NSString*)path;
+ (UIImage*) imageWithFileInBundle:(NSString*)file ofType:(NSString*)ext;

@end
