


#import "Validator.h"
#import "QuartzCore/QuartzCore.h"

@interface Validator()

// Private Method
- (Rule *)validateAllRules;
@end

@implementation Validator
@synthesize delegate;
@synthesize nRules;

- (id)init {
    self = [super init];
    if (self) {
        nRules = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 * Add a {Rule} to the Validator.
 * param-rule The {Rule} associated with the textField that has to be validated.
 */
- (void)putRule:(Rule *)rule {
    
    [nRules addObject:rule];            
}

/**
 * Validate all the {Rule}s against their associated {TextField}s.
 */
- (void)validate {
    
    /**
     * Called before the Validator begins validation.
     */
    [self.delegate preValidation];
    
    Rule *failedRule = [self validateAllRules];
    if (failedRule == NULL) {
        [self.delegate onSuccess:nRules];
    } else {
        /**
         * Called if any of the {Rule}s fail.
         * param-failedRule The failed {Rule} associated with the {TextField} that did not pass validation..
         */

        [self.delegate onFailure:failedRule];
    }
}

/**
 * Validates all rules added to this Validator.
 * return null if all {Rule}s are valid, else returns the failed{Rule}.
 */
- (Rule *)validateAllRules {
    
    Rule *failedRule = NULL;
    for (Rule *rule in nRules) {
        
        if (rule == NULL) continue;
        if (!rule.isValid) {
            failedRule = rule;
            break;
        }
    }
    
    return failedRule;
}


@end
