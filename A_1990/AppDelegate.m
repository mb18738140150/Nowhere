//
//  AppDelegate.m
//  A_1990
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import "AppDelegate.h"
#import "TWTSideMenuViewController.h"
#import "LeftSideViewController.h"

@interface AppDelegate ()<TWTSideMenuViewControllerDelegate>

@property (nonatomic , retain) TWTSideMenuViewController *sideMenuViewController;
@property (nonatomic , retain) LeftSideViewController *leftSideVC;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //根视图控制器
//    _mainVC = [[MainViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.mainVC];
//    self.window.rootViewController = nav;
//    [self.mainVC release];
//    [nav release];
    
    _mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.mainVC];
    _leftSideVC = [[LeftSideViewController alloc]init];
    
    self.sideMenuViewController = [[TWTSideMenuViewController alloc]initWithMenuViewController:self.leftSideVC mainViewController:nav];
    self.sideMenuViewController.edgeOffset = (UIOffset) {.horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 18.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 1.0f : 1.0f;
    self.sideMenuViewController.delegate = self;
    self.window.rootViewController = self.sideMenuViewController;
    
    
    
    
    return YES;
}

-(void)dealloc
{
    [_mainVC release];
    [super dealloc];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
