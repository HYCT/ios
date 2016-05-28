

#import "Rules.h"
#import "ValidatorRules.h"

@implementation Rules

static Rules *sharedInstance = nil;

+ (Rules *)sharedInstance 
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

+ (Rule *)maxLength:(int)maxLength withFailureString:(NSString *)failureString forTextField:(UITextField *)textField
{
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    if (textField.text.length > maxLength) {
        
        resultRule.isValid = NO;
    } else {
        
        resultRule.isValid = YES;
    }
    return resultRule;
}

+ (Rule *)minLength:(int)minLength withFailureString:(NSString *)failureString forTextField:(UITextField *)textField
{
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    if (textField.text.length < minLength) {
        
        resultRule.isValid = NO;
    } else {
        
        resultRule.isValid = YES;
    }
    
    return resultRule;
}

+ (Rule *)checkRange:(NSRange )range withFailureString:(NSString *)failureString forTextField:(UITextField *)textField 
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkIfInRange:textField.text WithRange:range];
    
    return resultRule;
}

+ (Rule *)checkIfNumericWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkNumeric:textField.text];
    return resultRule;
}

+ (Rule *)checkIfAlphaNumericWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkIfAlphaNumeric:textField.text];
    return resultRule;
}

+ (Rule *)checkIfAlphabeticalWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkIfAlphabetical:textField.text];
    return resultRule;
}

+ (Rule *)checkIsValidEmailWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField
{

    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkIfEmailId:textField.text];
    return resultRule;
}

+ (Rule *)checkIfURLWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField
{

    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkIfURL:textField.text];
    return resultRule;
}

+ (Rule *)checkIfShortandURLWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField
{
    
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkIfShorthandURL:textField.text];
    return resultRule;
}
+ (Rule *)checkIfPhoneNumberWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField{
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkIfPhoneNumeric:textField.text];
    return resultRule;
}
+ (Rule *)checkIfPassWord:(NSString *)failureString forTextField:(UITextField *)textField{
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkIfPassWord:textField.text];
    return resultRule;
}
+ (Rule *)checkIfNotPasswordEqual:(NSString *)failureString forTextField1:(UITextField *)textField1 forTextField2:(UITextField *)textField2{
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField1;
    resultRule.isValid = ![textField1.text isNotEqualToString:textField2.text];
    return resultRule;
}
+ (Rule *)checkIfOldPasswordEqualNewPwd:(NSString *)failureString forTextField1:(UITextField *)textField1 forTextField2:(UITextField *)textField2{
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField1;
    resultRule.isValid = [textField1.text isNotEqualToString:textField2.text];
    return resultRule;
}
+ (Rule *)checkIfIDCardNumberWithFailureString:(NSString *)failureString forTextField:(UITextField *)textField{
    Rule *resultRule = [[Rule alloc] init];
    resultRule.failureMessage = failureString;
    resultRule.textField = textField;
    resultRule.isValid = [NSString checkIfIDCardNumber:textField.text];
    return resultRule;
}
@end
