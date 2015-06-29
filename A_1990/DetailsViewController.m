//
//  DetailsViewController.m
//  A_1990
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.webView.backgroundColor = [UIColor whiteColor];
    
    
    NSURL *url = [NSURL URLWithString:self.webHtml];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    
    // 详情界面toolBar
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, kToolBarY, self.view.frame.size.width, kTooBarHeight)];
    
    toolBar.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *backItme = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItem:)];
        
    NSArray *items = [NSArray arrayWithObjects:backItme, nil];
    toolBar.items = items;
    
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    [self.webView addSubview:toolBar];
    
    [self.webView release];
    [toolBar release];
    
}

#pragma mark ToolBar 返回按钮
- (void)backItem:(UIBarButtonItem *)sender
{
    [self.webView goBack];
    
#warning dismiss回原控制器后,home页和paper页的列表布局会置顶 (*** 待解决 ***)
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回");
    }];
    
    
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
- (void)dealloc
{
    _webHtml = nil;
    [_webView release];
    [super dealloc];
}
@end
