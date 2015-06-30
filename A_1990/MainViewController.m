//
//  MainViewController.m
//  A_1990
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UIScrollViewDelegate>

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //关闭导航条毛玻璃效果  
    self.navigationController.navigationBar.translucent = NO;
    
    
    //获取屏幕宽度和高度
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    CGFloat viewHeight = CGRectGetHeight(self.view.frame);
    
    //创建home和paper按钮
    self.homeBtn = [Function createButtonWithName:@"home" andFrame:CGRectMake(0, 0 , viewWidth / 2, kTopBtnHeight)];
    self.homeBtn.tag = 101;
    [self.homeBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    //默认home按钮为选中状态
    self.homeBtn.selected = YES;
    
    self.paperBtn = [Function createButtonWithName:@"paper" andFrame:CGRectMake(viewWidth / 2, 0 , viewWidth / 2 , kTopBtnHeight)];
    self.paperBtn.tag = 102;
    [self.paperBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.homeBtn.backgroundColor = [UIColor yellowColor];
    self.paperBtn.backgroundColor = [UIColor yellowColor];
    
 
    //创建scrollView,控制home和paper两个界面的滑动切换
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , viewWidth, viewHeight - kTopBtnHeight)];
    //****  不允许垂直方向上进行滚动  ****
    self.scrollView.contentSize = CGSizeMake(viewWidth * 2 , 0);
    //设置scrollView属性
    //整页翻动
    self.scrollView.pagingEnabled = YES;
    //边缘无弹回效果
    self.scrollView.bounces = NO;
    //不显示水平,垂直滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    //切换视图
#warning 切换视图时会出现无法拖动tableView的情况,待优化
   
    self.homeVC = [[HomeCollectionViewController alloc]initWithFrame:self.view.bounds];
    self.paperVC = [[PaperTableViewController alloc]init];
    UIView *view1 = self.homeVC.view;
    UIView *view2 = self.paperVC.view;

    view1.frame = CGRectMake(0, 0, viewWidth, viewHeight - kTopBtnHeight);
    view2.frame = CGRectMake(viewWidth ,0, viewWidth , viewHeight - kTopBtnHeight);
    //设置scrollView代理
    self.scrollView.delegate = self;
    
    //添加
    [self.scrollView addSubview:view1];
    [self.scrollView addSubview:view2];
    [self.view addSubview:self.scrollView];
    
    [self.navigationController.view addSubview:self.homeBtn];
    [self.navigationController.view addSubview:self.paperBtn];
    

    [self addChildViewController:self.homeVC];
    [self addChildViewController:self.paperVC];
    
    
}


#pragma mark - top按钮点击选择
-(void)clickAction:(UIButton *)sender
{
    NSLog(@"测试topBtn点击");
    switch (sender.tag) {
        case 101:
            self.homeBtn.selected = YES;
            self.paperBtn.selected = NO;
            self.scrollView.contentOffset = CGPointMake(0 , 0);
            NSLog(@"测试homeBtn点击");
            break;
        case 102:
            self.homeBtn.selected = NO;
            self.paperBtn.selected = YES;
            self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width , 0);
            NSLog(@"测试paperBtn点击");
            break;
        default:
            break;
    }
}

#pragma mark - scrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算偏移几个view的宽度
    NSInteger index = scrollView.contentOffset.x / self.view.frame.size.width;
    //滑动切换界面
    switch (index) {
        case 0:
            self.homeBtn.selected = YES;
            self.paperBtn.selected = NO;
            self.scrollView.contentOffset = CGPointMake(0, 0);
            break;
        case 1:
            self.paperBtn.selected = YES;
            self.homeBtn.selected = NO;
            self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
            break;
        default:
            break;
    }
}


-(void)dealloc
{
    [_homeBtn release];
    [_paperBtn release];
    [_scrollView release];
    [_homeVC release];
    [_paperVC release];
    [super dealloc];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
