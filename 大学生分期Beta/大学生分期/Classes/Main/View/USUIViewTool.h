//
//  USUIViewTool.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/2.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USUIViewTool : NSObject
+(void)toLoginViewController;
+(void)createMainNavController:(UIViewController *)showVC;
+(void)chageWindowRootController:(UIViewController *)rootViewController;
+(void)toLoginViewController:(UIViewController *)showVC;
+(UIView *)createLineView;
+(UIView *)createLineView:(CGFloat)x y:(CGFloat)y width:(CGFloat)width;
+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae;
+(UILabel *)createUILabel;
+(UIButton *)createButtonWith:(NSString*)title;
+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae highImageName:(NSString*)highImageName;+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae highImageName:(NSString*)highImageName disableImageName:(NSString*)disableImageName;
+(NSAttributedString *)createAttrbutedStringWithHtml:(NSString *)htmlString;
+(UILabel*)createUILabelWithTitle:(NSString *)title fontSize:(CGFloat)size color:(UIColor *)color heigth:(CGFloat)heigth;
+(UILabel*)createUILabelWithTitle:(NSString *)title fontSize:(CGFloat)size color:(UIColor *)color x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width heigth:(CGFloat)heigth;
+(UIView *)createComplexViewWithTile:(NSString *)title imageName:(NSString *)imageName fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor bgsize:(CGSize) bgsize bgColor:(UIColor *)bgColor;
+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae highImageName:(NSString*)highImageName selectedImageName:(NSString*)selectedImageName;
+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae highImageName:(NSString*)highImageName selectedImageName:(NSString*)selectedImageName flag:(Boolean) flag;
+(UIView *)createDataTipViewWithTarget:(nullable id)target action:(SEL)action;
//图片自适应
+(void)imagesSelfFit:(UIImageView *)imageview;
//text自适应高度
+(CGFloat )setTextHeight:(UILabel *)label width:(CGFloat)width content:(NSString *)content font:(UIFont *)font ;
@end
