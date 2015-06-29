//
//  MainViewController.h
//  A_1990
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewController.h"
#import "PaperTableViewController.h"

@interface MainViewController : UIViewController

@property (nonatomic , retain) UIScrollView *scrollView;
@property (nonatomic , retain) UIButton *homeBtn;
@property (nonatomic , retain) UIButton *paperBtn;
@property (nonatomic , retain) HomeCollectionViewController *homeVC;
@property (nonatomic , retain) PaperTableViewController *paperVC;


@end
