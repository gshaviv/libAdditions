/*

File: URLCacheAlert.h
Abstract: Utility functions for the URLCache sample.

Version: 1.0


*/

#import <UIKit/UIKit.h>

@interface UIAlertView (shortcuts)

+ (UIAlertView*) alertWithError:(NSError *)error;
+ (UIAlertView*) alertWithMessage:(NSString *)message;
+ (UIAlertView*) alertWithTitle:(NSString *) title andMessage:(NSString *)message;
+ (UIAlertView*) alertWithMessage:(NSString *)message title:(NSString *) title andDelegate:(id) delegate;
+ (UIAlertView*) alertWithMessage:(NSString *)message 
					title:(NSString *) title 
				 okButton:(NSString *) ok
			 cancelButton:(NSString*)cancel
				 delegate:(id) delegate;
- (UIAlertView*) customizeWithTitleColor:(UIColor*)tcolor messageColor:(UIColor*)mcolor image:(UIImage*)image;
@end


