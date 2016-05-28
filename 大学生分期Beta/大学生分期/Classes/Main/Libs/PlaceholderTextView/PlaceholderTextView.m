
#import "PlaceholderTextView.h"
#import <QuartzCore/QuartzCore.h> 
@interface PlaceholderTextView()<UITextViewDelegate>
{
    UILabel *PlaceholderLabel;
}

@end
@implementation PlaceholderTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        [self awakeFromNib];
        self.layer.borderColor = [[UIColor clearColor] CGColor];
        self.layer.borderWidth = 0;
        self.delegate = self;
    }
    return self;
}


- (void)awakeFromNib {
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnd:) name:UITextViewTextDidEndEditingNotification object:self];

    float left=5,top=2,hegiht=30;
    
    self.placeholderColor = [UIColor lightGrayColor];
    PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame)-2*left, hegiht)];
    PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
    PlaceholderLabel.textColor=self.placeholderColor;
    [self addSubview:PlaceholderLabel];
    PlaceholderLabel.text=self.placeholder;

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    else
        PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;

    
}

-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
        if (_didEndBlock) {
            self.didEndBlock(YES);
        }
       
    }
    
    if (self.text.length > 0) {
        PlaceholderLabel.hidden=YES;
        if (_didEndBlock) {
            self.didEndBlock(YES);
        }
    }
    else{
        PlaceholderLabel.hidden=NO;
        if (_didEndBlock) {
            self.didEndBlock(NO);
        }
        
    }
    
    
}
-(void)didEnd:(NSNotification*)noti{
    
    if (_didEndBlock) {
        [self DidChange:nil];
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}


@end

