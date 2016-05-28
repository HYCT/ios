//
//  USTextFieldToo.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/7.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USTextFieldTool.h"
#define kPlaceholderFontSize 15
@implementation USTextFieldTool
+(UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder target:(id)target leftImage:(NSString *)leftImageName{
    USTextField *textField = [[USTextField alloc]initWithFrame:CGRectMake(10, 64,kAppWidth-20, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = target;
    textField.layer.masksToBounds = YES;
    textField.backgroundColor = [UIColor clearColor];
    textField.borderStyle=UITextBorderStyleNone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    CGFloat percent = (textField.frame.size.height/textField.frame.size.width -0.05)<0.05?0.06:(textField.frame.size.height/textField.frame.size.width-0.05);
    textField.layer.cornerRadius = textField.height*0.5;
    textField.layer.borderColor=  [HYCTColor(163, 163, 163) CGColor];
    textField.layer.borderWidth= 0.50f;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kPlaceholderFontSize]}];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width*0.06, textField.height/2)];
   textField.fontSize = 5;
    if (leftImageName!=NULL) {
        textField.leftView = [[UIView alloc]init];
        UIImage *img = [UIImage imageNamed:leftImageName];
//         UIImage *img = [[UIImage imageNamed:leftImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = img;
        imageView.frame = CGRectMake(15, 5, 15,22);
        //imageView.size = img.size;
        [textField.leftView addSubview:imageView];
        CGRect frame = CGRectMake(0, 0, 40, 35);
        textField.leftView.frame = frame;
    }else{
       textField.leftView = view;
    }

    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}
+(UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder target:(id)target leftImage:(NSString *)leftImageName imageFrame:(CGRect)frame{
    USTextField *textField = [[USTextField alloc]initWithFrame:CGRectMake(10, 64,kAppWidth-20, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = target;
    textField.layer.masksToBounds = YES;
    textField.backgroundColor = [UIColor clearColor];
    textField.borderStyle=UITextBorderStyleNone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    CGFloat percent = (textField.frame.size.height/textField.frame.size.width -0.05)<0.05?0.06:(textField.frame.size.height/textField.frame.size.width-0.05);
    textField.layer.cornerRadius = textField.height*0.5;
    textField.layer.borderColor=  [HYCTColor(163, 163, 163) CGColor];
    textField.layer.borderWidth= 0.50f;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kPlaceholderFontSize]}];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width*0.06, textField.height/2)];
    textField.fontSize = 5;
    if (leftImageName!=NULL) {
        textField.leftView = [[UIView alloc]init];
        UIImage *img = [UIImage imageNamed:leftImageName];
        //         UIImage *img = [[UIImage imageNamed:leftImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = img;
        imageView.frame = frame;
        //imageView.size = img.size;
        [textField.leftView addSubview:imageView];
        CGRect frame = CGRectMake(0, 0, 40, 35);
        textField.leftView.frame = frame;
    }else{
        textField.leftView = view;
    }
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

/*
+(UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder target:(id)target leftImage:(NSString *)leftImageName{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 64,kAppWidth-20, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = target;
    textField.layer.masksToBounds = YES;
    textField.backgroundColor = [UIColor clearColor];
    textField.borderStyle=UITextBorderStyleNone;
    CGFloat percent = (textField.frame.size.height/textField.frame.size.width -0.05)<0.05?0.06:(textField.frame.size.height/textField.frame.size.width-0.05);
    textField.layer.cornerRadius = textField.frame.size.width*percent;
    textField.layer.borderColor=  [HYCTColor(163, 163, 163) CGColor];
    textField.layer.borderWidth= 0.8f;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //textField.placeholder = Placeholder;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width*0.06, textField.height/2)];
    if (leftImageName!=NULL) {
        UIImageView *leftImageView = [[UIImageView alloc]initWithImage: [[UIImage imageNamed:leftImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        CGRect frame = leftImageView.frame;
        view.size = leftImageView.size;
        view.width+=10;
        frame.origin.x = 8;
        frame.origin.y = -2;
        leftImageView.frame = frame;
        [view addSubview:leftImageView];
    }
    textField.keyboardType = UIKeyboardTypeURL;
    textField.leftView = view;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}*/

@end
