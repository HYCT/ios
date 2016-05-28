

#import <UIKit/UIKit.h>

/**
 *  要是用非 arc。。。。。。／／     -fno-objc-arc
 */
typedef void (^didEndBlock)(BOOL flag);
@interface PlaceholderTextView : UITextView

@property(copy,nonatomic) NSString *placeholder;
@property(strong,nonatomic) UIColor *placeholderColor;
@property(strong,nonatomic) UIFont * placeholderFont;
@property(copy,nonatomic) didEndBlock didEndBlock;
@end
