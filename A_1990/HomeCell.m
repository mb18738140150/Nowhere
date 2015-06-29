//
//  HomeCell.m
//  A_1990
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

//homeImage懒加载
-(EGOImageView *)homeImage
{
    if (!_homeImage) {
        self.homeImage = [[EGOImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.width * kImageHeight / kImageWidth)];
        //设置等待加载图片
//        _homeImage.placeholderImage = [UIImage imageNamed:@"placeholderImage.jpg"];
        [self.contentView addSubview:_homeImage];
        [_homeImage release];
    }
    return _homeImage;
    
    
}

//title懒加载
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.homeImage.frame.size.height , self.contentView.bounds.size.width , self.contentView.bounds.size.height - self.homeImage.frame.size.height)];
        toolBar.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:toolBar];

#warning 此处title显示需要优化 (多行显示,且可以根据实际情况,改变字体风格)
        self.titleLabel = [Function createLabelWithName:@"test" andFrame:CGRectMake(0, 0 , self.contentView.bounds.size.width , kTitleLabelHeight)];
        [toolBar addSubview:_titleLabel];
        [_titleLabel release];
        [toolBar release];
    }
    return _titleLabel;
}

-(void)dealloc
{
    [_titleLabel release];
    [_homeImage release];
    [super dealloc];
}


@end
