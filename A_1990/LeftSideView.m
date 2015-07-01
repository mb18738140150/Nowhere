//
//  LeftSideView.m
//  A_1990
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import "LeftSideView.h"

@implementation LeftSideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview];
    }
    return self;
}

- (void)addSubview
{
    // 添加背景图片
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:self.backgroundImageView];
//    self.contentSize = CGSizeMake(self.frame.size.width, 850);
//    self.showsVerticalScrollIndicator = NO;
    
    NSDictionary *viewDictionary = @{ @"imageView" : self.backgroundImageView };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    
    
    // 添加登陆Button
    self.loginButton = [Function createButtonWithName:@"登陆" andFrame:CGRectMake(koriginX + 30, Koriginy - 80, Kwidth, Kheight)];
    self.loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:self.loginButton];
    // 添加首页Button

    self.firstPageButton = [Function createButtonWithName:@"首页" andFrame:CGRectMake(koriginX, Koriginy, Kwidth, Kheight)];
    self.firstPageButton.backgroundColor = [UIColor blueColor];
    [self addSubview:self.firstPageButton];
    // 添加收藏Button
    self.collectButton = [Function createButtonWithName:@"收藏" andFrame:CGRectMake(self.firstPageButton.frame.origin.x, self.firstPageButton.frame.origin.y + self.firstPageButton.frame.size.height + kSpace, Kwidth, Kheight)];
    self.collectButton.backgroundColor = [UIColor blueColor];
    [self addSubview:self.collectButton];
    // 商业button
    self.commerceButton = [Function createButtonWithName:@"商业" andFrame:CGRectMake(self.collectButton.frame.origin.x, self.collectButton.frame.origin.y + self.collectButton.frame.size.height + kSpace, Kwidth, Kheight)];
    self.commerceButton.backgroundColor = [UIColor blueColor];
    self.commerceButton.tag = 101;
    [self addSubview:self.commerceButton];
    // 智能Button
    self.intelligentButton = [Function createButtonWithName:@"智能" andFrame:CGRectMake(self.commerceButton.frame.origin.x, self.commerceButton.frame.origin.y + self.commerceButton.frame.size.height + kSpace, Kwidth, Kheight)];
    self.intelligentButton.backgroundColor = [UIColor blueColor];
    self.intelligentButton.tag = 102;
    [self addSubview:self.intelligentButton];
    // 设计Button
    self.desginButton = [Function createButtonWithName:@"设计" andFrame:CGRectMake(self.intelligentButton.frame.origin.x, self.intelligentButton.frame.origin.y + self.intelligentButton.frame.size.height + kSpace, Kwidth, Kheight)];
    self.desginButton.backgroundColor = [UIColor blueColor];
    self.intelligentButton.tag = 103;
    [self addSubview:self.desginButton];
    // 时尚button
    self.fashinoButton = [Function createButtonWithName:@"时尚" andFrame:CGRectMake(self.desginButton.frame.origin.x, self.desginButton.frame.origin.y + self.desginButton.frame.size.height + kSpace, Kwidth, Kheight)];
    self.fashinoButton.backgroundColor = [UIColor blueColor];
    self.fashinoButton.tag = 104;
    [self addSubview:self.fashinoButton];
    // 娱乐button
    self.entertainButton = [Function createButtonWithName:@"娱乐" andFrame:CGRectMake(self.fashinoButton.frame.origin.x, self.fashinoButton.frame.origin.y + self.fashinoButton.frame.size.height + kSpace, Kwidth, Kheight)];
    self.entertainButton.backgroundColor = [UIColor blueColor];
    self.entertainButton.tag = 105;
    [self addSubview:self.entertainButton];
    // 城市button
    self.cityButton = [Function createButtonWithName:@"城市" andFrame:CGRectMake(self.entertainButton.frame.origin.x, self.entertainButton.frame.origin.y + self.entertainButton.frame.size.height + kSpace, Kwidth, Kheight)];
    self.cityButton.backgroundColor = [UIColor blueColor];
    self.cityButton.tag = 106;
    [self addSubview:self.cityButton];
    // 游戏button
    self.gameButton = [Function createButtonWithName:@"游戏" andFrame:CGRectMake(self.cityButton.frame.origin.x, self.cityButton.frame.origin.y + self.cityButton.frame.size.height + kSpace, Kwidth, Kheight)];
    self.gameButton.backgroundColor = [UIColor blueColor];
    self.gameButton.tag = 107;
    [self addSubview:self.gameButton];
    
    // 设置Button
 
    self.setButton = [Function createButtonWithName:@"设置" andFrame:CGRectMake(self.gameButton.frame.origin.x + 10, self.gameButton.frame.origin.y + self.gameButton.frame.size.height + kSpace * 2, Kwidth, Kheight)];
    [self addSubview:self.setButton];
    // 查找Button
    self.searchButton = [Function createButtonWithName:@"查找" andFrame:CGRectMake(self.setButton.frame.origin.x + self.setButton.frame.size.width + kSpace, self.setButton.frame.origin.y, Kwidth, Kheight)];
    [self addSubview:self.searchButton];
    
}

- (void)dealloc
{
    [self.backgroundImageView release];
    [self.loginButton release];
    [self.firstPageButton release];
    [self.collectButton release];
    [self.commerceButton release];
    [self.intelligentButton release];
    [self.desginButton release];
    [self.fashinoButton release];
    [self.entertainButton release];
    [self.cityButton release];
    [self.gameButton release];
    [self.setButton release];
    [self.searchButton release];
    [super dealloc];
}


@end
