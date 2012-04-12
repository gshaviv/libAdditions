

#import "BlockAlertView.h"

@interface BlockAlertView () <UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *blocksArray;

@end

#pragma mark - Implementation

@implementation BlockAlertView

@synthesize blocksArray;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButton cancelBlock:(void (^)(void))cancelBlock {
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButton otherButtonTitles:nil];
    if (self) {
        self.blocksArray = [NSMutableArray array];
        [self.blocksArray addObject:[cancelBlock copy]];
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title selectionBlock:(void (^)(void))selectionBlock {
    [super addButtonWithTitle:title];
    [self.blocksArray addObject:[selectionBlock copy]];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex >= 0 && buttonIndex < blocksArray.count) {
        void(^block)(void) = [self.blocksArray objectAtIndex:buttonIndex];
        block();
    }
}

@end
