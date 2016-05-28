


#import <Foundation/Foundation.h>
#import "Rule.h"

@interface Rules : NSObject

+ (id)sharedInstance;

+ (Rule *)maxLength:(int)maxLength withFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)minLength:(int)minLength withFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkRange:(NSRange )range withFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIfNumericWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIfAlphaNumericWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIfAlphabeticalWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIsValidEmailWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIfURLWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIfShortandURLWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIfPhoneNumberWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIfPassWord:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIfNotPasswordEqual:(NSString *)failureString forTextField1:(UITextField *)textField1 forTextField2:(UITextField *)textField2;
+ (Rule *)checkIfIDCardNumberWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField;
+ (Rule *)checkIfOldPasswordEqualNewPwd:(NSString *)failureString forTextField1:(UITextField *)textField1 forTextField2:(UITextField *)textField2;
@end
