#import "UIImageAdditions.h"
#import "CGGeometryAdditions.h"

@implementation UIImage (TTCategory)

+ (UIImage*) imageWithFileInBundle:(NSString*)file {
	return [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:file]];
}

+ (UIImage*) imageWithFileInBundle:(NSString*)file ofType:(NSString*)ext {
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]];
}

+ (UIImage*) imageWithContentsOfUrl:(NSString*)path {
	NSURL *url = [NSURL URLWithString:path];
	NSData *data = [NSData dataWithContentsOfURL:url];
	return [UIImage imageWithData:data];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
  CGContextBeginPath(context);
  CGContextSaveGState(context);

  if (radius == 0) {
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddRect(context, rect);
  } else {
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, radius, radius);
    float fw = CGRectGetWidth(rect) / radius;
    float fh = CGRectGetHeight(rect) / radius;
    
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
  }

  CGContextClosePath(context);
  CGContextRestoreGState(context);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate {
//  CGFloat destW = width;
//  CGFloat destH = height;
  CGFloat sourceW = width;
  CGFloat sourceH = height;
  if (rotate) {
    if (self.imageOrientation == UIImageOrientationRight
        || self.imageOrientation == UIImageOrientationLeft) {
      sourceW = height;
      sourceH = width;
    }
  }
  
//  CGImageRef imageRef = self.CGImage;
//  CGContextRef bitmap = CGBitmapContextCreate(NULL, destW, destH,
//    CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), CGImageGetColorSpace(imageRef),
//    CGImageGetBitmapInfo(imageRef));


//  CGContextDrawImage(bitmap, CGRectMake(0,0,sourceW,sourceH), imageRef);
//
//  CGImageRef ref = CGBitmapContextCreateImage(bitmap);
//  UIImage* result = [UIImage imageWithCGImage:ref];
//  CGContextRelease(bitmap);
//  CGImageRelease(ref);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, self.scale);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextScaleCTM(ctx, 1., -1);
    if (rotate) {
        if (self.imageOrientation == UIImageOrientationDown) {
            CGContextTranslateCTM(ctx, sourceW, sourceH);
            CGContextRotateCTM(ctx, 180 * (M_PI/180));
        } else if (self.imageOrientation == UIImageOrientationLeft) {
            CGContextTranslateCTM(ctx, sourceH, 0);
            CGContextRotateCTM(ctx, 90 * (M_PI/180));
        } else if (self.imageOrientation == UIImageOrientationRight) {
            CGContextTranslateCTM(ctx, 0, sourceW);
            CGContextRotateCTM(ctx, -90 * (M_PI/180));
        }
    }

	CGContextDrawImage(ctx, CGRectMake(0, -height, width, height), self.CGImage);
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return viewImage;
}

- (UIImage*)imageWithWidth:(CGFloat)width height:(CGFloat)height {
//	UIGraphicsBeginImageContext(CGSizeMake(width, height));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, width, height)];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return viewImage;
}

- (UIImage*)imageWithSize:(CGSize)size contentMode:(UIViewContentMode)contentMode {
    if (contentMode == UIViewContentModeScaleAspectFit) {
        float scale = MIN(size.width / (float)self.size.width, size.height / (float)self.size.height);
        size = CGSizeMake(rintf(self.size.width * scale), rintf(self.size.height * scale));
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height) contentMode:contentMode];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return viewImage;
}

- (UIImage*) imageThatFitsDimension:(CGFloat)maxDim {
    CGSize size = self.size;
    if (size.width > size.height) {
        return [self imageWithWidth:maxDim height:rintf(maxDim/size.width * size.height)];
    } else {
        return [self imageWithWidth:rintf(maxDim/size.height*size.width) height:maxDim];
    }
}

- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
  BOOL clip = NO;
  CGRect originalRect = rect;
  if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
    if (contentMode == UIViewContentModeLeft) {
      rect = CGRectMake(rect.origin.x,
                        rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeRight) {
      rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                        rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeTop) {
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                        rect.origin.y,
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeBottom) {
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                        rect.origin.y + floor(rect.size.height - self.size.height),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeCenter) {
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                        rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                        self.size.width, self.size.height);
    } else if (contentMode == UIViewContentModeBottomLeft) {
      rect = CGRectMake(rect.origin.x,
                        rect.origin.y + floor(rect.size.height - self.size.height),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeBottomRight) {
      rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                        rect.origin.y + (rect.size.height - self.size.height),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeTopLeft) {
      rect = CGRectMake(rect.origin.x,
                        rect.origin.y,
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeTopRight) {
      rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                        rect.origin.y,
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeScaleAspectFill) {
      CGSize imageSize = self.size;
      if (imageSize.height < imageSize.width) {
        imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
        imageSize.height = rect.size.height;
      } else {
        imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
        imageSize.width = rect.size.width;
      }
      rect = CGRectMakeRound(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                        rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                        imageSize.width, imageSize.height);
    } else if (contentMode == UIViewContentModeScaleAspectFit) {
      CGSize imageSize = self.size;
      if (imageSize.height < imageSize.width) {
        imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
        imageSize.width = rect.size.width;
      } else {
        imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
        imageSize.height = rect.size.height;
      }
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                        rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                        imageSize.width, imageSize.height);
    }
  }
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  if (clip) {
    CGContextSaveGState(context);
    CGContextAddRect(context, originalRect);
    CGContextClip(context);
  }

  [self drawInRect:rect];

  if (clip) {
    CGContextRestoreGState(context);
  }
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius {
  [self drawInRect:rect radius:radius contentMode:UIViewContentModeScaleToFill];
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  if (radius) {
    [self addRoundedRectToPath:context rect:rect radius:radius];
    CGContextClip(context);
  }
  
  [self drawInRect:rect contentMode:contentMode];
  
  CGContextRestoreGState(context);
}

@end
