 

#import "TooltipView.h"
#import "TooltipViewPrivate.h"

static const CGFloat kMargin = 10.0;

@implementation TooltipView

@synthesize text = _text;
@synthesize rule;

#pragma mark - Initialization

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self _buildUserInterface];
    }
    
    return self;
}

#pragma mark - Update user interface

- (void)_buildUserInterface
{
    // Let the tooltip resize automatically in width
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.userInteractionEnabled = YES;
    // Add text field
    CGRect textLabelFrame      = CGRectMake(kMargin, 10.0, self.frame.size.width - kMargin - kMargin, 50.0);
    _textLabel                 = [[UILabel alloc] initWithFrame:textLabelFrame];
    _textLabel.textColor       = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _textLabel.font            = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
    _textLabel.numberOfLines   = 2;
    _textLabel.minimumFontSize = 11.0;
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.adjustsFontSizeToFitWidth = YES;
    _textLabel.lineBreakMode   = UILineBreakModeWordWrap;
    _textLabel.shadowColor     = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    _textLabel.shadowOffset    = CGSizeMake(0.0, 1.0);
    [self addSubview:_textLabel];
}

#pragma mark - Update user interface

/**
 Update UI
*/
- (void)_updateUserInterface
{
    _textLabel.text = _text;
    
    // Update height of tooltip
    [self _collapseToContent];
}

/**
 Updating height of tooltip depending on label height
*/
- (void)_collapseToContent
{
    CGSize size = [_textLabel.text sizeWithFont:_textLabel.font
                              constrainedToSize:CGSizeMake(self.frame.size.width - kMargin - kMargin, 9999)
                                  lineBreakMode:_textLabel.lineBreakMode];
    
    _textLabel.frame = CGRectMake(kMargin, 10.0, self.frame.size.width - kMargin - kMargin, size.height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height + 14.0);
}

#pragma mark - Text

/**
 Set text for presenting on tooltip
*/
- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    [self _updateUserInterface];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [rule.textField becomeFirstResponder];
    [self removeFromSuperview];
}

@end
