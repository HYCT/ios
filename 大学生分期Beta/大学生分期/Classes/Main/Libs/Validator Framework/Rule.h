
#import <Foundation/Foundation.h>

@interface Rule : NSObject {
    @private
    NSString *failureMessage;
    BOOL isValid;
    UITextField *textField;
}
@property (nonatomic, retain) NSString *failureMessage;
@property (nonatomic) BOOL isValid;
@property (nonatomic, retain) UITextField *textField;
@end
