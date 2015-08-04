//
//  AppDelegate.h
//  A_1990
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic , retain) MainViewController *mainVC;

@property (nonatomic , copy) NSString *uid;


@end

