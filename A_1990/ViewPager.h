//
//  ViewPager.h
//  A_1990
//
//  Created by lanouhn on 15/6/28.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIScrollViewTouchesDelegate <NSObject>

-(void)scrollViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event whichView:(id)scrollView;

@end


@interface ViewPager : UIView<UIScrollViewDelegate>

@property (nonatomic , assign) id<UIScrollViewTouchesDelegate>touchesDelegate;

@property (nonatomic , retain) UIScrollView *myScrollView;
@property (nonatomic , retain) UIPageControl *myPageControl;
@property (nonatomic , retain) NSTimer *timer;



//初始化scrollView,同时将存放轮播图url地址的数组传进来
-(instancetype)initWithFrame:(CGRect)frame andPages:(NSArray *)pages;

@end
