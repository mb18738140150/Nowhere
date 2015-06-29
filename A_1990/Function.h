//
//  Function.h
//  UILesson8_PassValueDemo
//
//  Created by lanouhn on 15/5/26.
//  Copyright (c) 2015年 scx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Function : NSObject


//创建label
+ (UILabel *)createLabelWithName:(NSString *)name andFrame:(CGRect)frame;

//创建输入框
+ (UITextField *)createTextFieldWithName:(NSString *)name andFrame:(CGRect)frame;

//创建btn
+ (UIButton *)createButtonWithName:(NSString *)name andFrame:(CGRect)frame;

//创建imageView
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame;





@end
