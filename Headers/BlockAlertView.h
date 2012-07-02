

#import <UIKit/UIKit.h>

@interface BlockAlertView : UIAlertView 
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButton cancelBlock:(void(^)(void))cancelBlock;
- (void)addButtonWithTitle:(NSString *)title selectionBlock:(void(^)(void))selectionBlock;

@end