//
//  LeftSideViewController.m
//  A_1990
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import "LeftSideViewController.h"
#import "ListViewController.h"
#import "MainViewController.h"
#import "TWTSideMenuViewController.h"

@interface LeftSideViewController ()

@end

@implementation LeftSideViewController

- (void)loadView
{
    [super loadView];
    self.leftSideView = [[LeftSideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.leftSideView;
    [self.leftSideView release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    // 给Button添加点击事件
    [self.leftSideView.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.firstPageButton addTarget:self action:@selector(firstPageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.commerceButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.intelligentButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.desginButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.leftSideView.fashinoButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.entertainButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.cityButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.gameButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.setButton addTarget:self action:@selector(setButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Button 点击事件
- (void)loginButtonAction:(UIButton *)sender
{
    NSLog(@"login");
}

- (void)firstPageButtonAction:(UIButton *)sender
{
    NSLog(@"firstPage");
}
- (void)collectButtonAction:(UIButton *)sender
{
    NSLog(@"collect");
}
- (void)listButtonAction:(UIButton *)sender
{
    ListViewController *listVC = [[ListViewController alloc] init];
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    [self.sideMenuViewController setMainViewController:nav animated:YES closeMenu:YES];
    mainVC.homeBtn.hidden = YES;
    mainVC.paperBtn.hidden = YES;
    [nav pushViewController:listVC animated:YES];
    
    [listVC release];
    
    
}


- (void)setButtonAction:(UIButton *)sender
{
    NSLog(@"set");
}

- (void)searchButtonAction:(UIButton *)sender
{
    NSLog(@"search");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [self.leftSideView release];
    [super dealloc];
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
