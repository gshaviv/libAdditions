/*

File: URLCacheAlert.m
Abstract: Utility functions for the URLCache sample.

Version: 1.0


*/

#import "Alert.h"
#import "QuartzCore/CALayer.h"


@implementation UIAlertView (shortcuts)

+ (UIAlertView*) alertWithError:(NSError *)error
{
    NSString *message = [NSString stringWithFormat:@"%@",[error localizedDescription]];
#ifdef _DEBUG
	NSDLog(@"Error: %@", [error localizedDescription]);
	NSArray* detailedErrors = [[error userInfo] objectForKey:@"NSDetailedErrors"];
	if(detailedErrors && [detailedErrors count] > 0) {
		for(NSError* detailedError in detailedErrors) {
			NSDLog(@"DetailedError: %@", [detailedError userInfo]);
		}
	} else {
		NSDLog(@"%@", error );
	}
#endif
	if ([[error domain] isEqualToString:NSURLErrorDomain]) {
		return [UIAlertView alertWithTitle:@"Network Error" andMessage:message];
	}
	return [UIAlertView alertWithMessage:message];
}

+ (UIAlertView*) alertWithMessage:(NSString *)message {
	/* open an alert with an OK button */
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
													message:message
												   delegate:nil 
										  cancelButtonTitle:NSLocalizedString(@"OK","Alert Button") 
										  otherButtonTitles: nil];
	[alert show];
//	[alert release];	
	return alert;
}

+ (UIAlertView*) alertWithTitle:(NSString *) title andMessage:(NSString *)message {
	/* open an alert with an OK button */
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
													message:message
												   delegate:nil 
										  cancelButtonTitle:NSLocalizedString(@"OK","Alert Button") 
										  otherButtonTitles: nil];
	[alert show];
//	[alert release];
	return alert;
}

+ (UIAlertView*) alertWithMessage:(NSString *)message title:(NSString *) title andDelegate:(id) delegate {
	/* open an alert with OK and Cancel buttons */
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
													message:message
												   delegate:delegate 
										  cancelButtonTitle:NSLocalizedString(@"Cancel","Alert button") 
										  otherButtonTitles: NSLocalizedString(@"OK","Alert button"), nil];
	[alert show];
//	[alert release];	
	return alert;
}

+ (UIAlertView*) alertWithMessage:(NSString *)message 
					title:(NSString *) title 
				 okButton:(NSString *) ok
			 cancelButton:(NSString*)cancel
				 delegate:(id) delegate {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
													message:message
												   delegate:delegate 
										  cancelButtonTitle:cancel 
										  otherButtonTitles: ok, nil];
	[alert show];
//	[alert release];	
	return alert;
}

- (UIAlertView*) customizeWithTitleColor:(UIColor*)tcolor messageColor:(UIColor*)mcolor image:(UIImage*)theImage {
	if (tcolor) {
		UILabel *theTitle = [self valueForKey:@"_titleLabel"];
		[theTitle setTextColor:tcolor];
	}
	
	if (mcolor) {
		UILabel *theBody = [self valueForKey:@"_bodyTextLabel"];
		[theBody setTextColor:mcolor];
	}
	
	if (theImage) {
		theImage = [theImage stretchableImageWithLeftCapWidth:16 topCapHeight:16];
		CGSize theSize = [self frame].size;
		
		UIGraphicsBeginImageContext(theSize); 
		[theImage drawInRect:CGRectMake(0, 0, theSize.width, theSize.height)]; 
		theImage = UIGraphicsGetImageFromCurrentImageContext(); 
		UIGraphicsEndImageContext();
		

		

		self.layer.contents = (id)[theImage CGImage];
	}
	
	return self;
}

@end

