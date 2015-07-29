//
//  AppDelegate.m
//  Agent
//
//  Created by 方浙徽 on 15/7/16.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+EaseMob.h"
#import "ApplyViewController.h"
#import "ZMLoginViewController.h"
#import "NSZMSession.h"
#import "ZMChatListViewController.h"
#import "ZMWaitedViewController.h"
#import "ZMSettingViewController.h"
#import "ZMNavigationController.h"

#define TABITEM_VIEWCONTROLLER(vcClass,vc,nc,titleString,imageString,itemSelectedImage,selectedImageString) \
vcClass *vc = [[vcClass alloc]initWithNibName:nil bundle:nil];\
ZMNavigationController *nc = [[ZMNavigationController alloc]initWithRootViewController:vc];\
nc.tabBarItem.title = titleString; \
[nc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CustomRedColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected]; \
nc.tabBarItem.image = [UIImage imageNamed:imageString]; \
UIImage *itemSelectedImage =[ UIImage imageNamed:selectedImageString]; \
itemSelectedImage = [itemSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; \
nc.tabBarItem.selectedImage = itemSelectedImage;\


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    [self loginStateChange:nil];
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];

    TABITEM_VIEWCONTROLLER(ZMChatListViewController,hotspotWebViewController,hotspotNavigationController,@"会话",@"tab_redian_0",hotspotSelectedImage,@"tab_redian_1") \
    TABITEM_VIEWCONTROLLER(ZMWaitedViewController,guessWebViewController,guessNavigationController,@"待接入",@"tab_caicai_0",guessSelectedImage,@"tab_caicai_1") \
    TABITEM_VIEWCONTROLLER(ZMSettingViewController,mineFieldWebViewController,mineFieldNavigationController,@"设置",@"tab_bangdan0",mineFieldSelectedImage,@"tab_bangdan1") \
    self.congTouHomeTabBarController = [[ZMHomeTabBarController alloc]initWithNibName:nil bundle:nil]; \
    self.congTouHomeTabBarController.delegate = self; \
    self.congTouHomeTabBarController.viewControllers = [NSArray arrayWithObjects:hotspotNavigationController,guessNavigationController,mineFieldNavigationController, nil];
    AppDelegate* del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    NSLog(@"APIURL：%@",SESSION);
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ZMLoginViewController* ctr = [[ZMLoginViewController alloc] init];
//    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:ctr];
    [self.window setRootViewController:ctr];
    
    [self.window makeKeyAndVisible];

    return YES;
}


#pragma mark - private
//登陆状态改变
-(void)loginStateChange:(NSNotification *)notification
{
    UINavigationController *nav = nil;
    
    //    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    //    BOOL loginSuccess = [notification.object boolValue];
    
    //    if (isAutoLogin || loginSuccess) {//登陆成功加载主窗口控制器
    //加载申请通知的数据
    [[ApplyViewController shareController] loadDataSourceFromLocalDB];
    if (_mainController == nil) {
        _mainController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
        [_mainController networkChanged:_connectionState];
        //            nav = [[UINavigationController alloc] initWithRootViewController:_mainController];
    }else{
        //            nav  = _mainController.navigationController;
    }
    //    }
    
    //设置7.0以下的导航栏
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                forBarMetrics:UIBarMetricsDefault];
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [nav.navigationBar.layer setMasksToBounds:YES];
    }
    nav.navigationBar.barStyle = UIBarStyleBlack;
    
    //    self.window.rootViewController = nav;
    //    [nav.navigationBar setBarTintColor:CustomRedColor];
    //    [nav setNavigationBarHidden:YES];
    //    [nav setNavigationBarHidden:NO];
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
