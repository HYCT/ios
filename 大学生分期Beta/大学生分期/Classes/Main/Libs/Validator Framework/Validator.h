

#import <Foundation/Foundation.h>
#import "Rule.h"
#import "Rules.h"

@protocol ValidatorDelegate <NSObject>

@optional
- (void)preValidation;

@required
- (void)onSuccess:(NSArray *)rules;
- (void)onFailure:(Rule *)failedRule;

@end

@interface Validator : NSObject{

    NSMutableArray *nRules;
}

@property (nonatomic, retain) NSMutableArray *nRules;
@property (nonatomic, retain) id <ValidatorDelegate> delegate;

- (void)validate;
- (void)putRule:(Rule *)rule;
@end
