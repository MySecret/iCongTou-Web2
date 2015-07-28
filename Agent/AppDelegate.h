//
//  AppDelegate.h
//  Agent
//
//  Created by 方浙徽 on 15/7/16.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ZMHomeTabBarController.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

{
    int applicationState;
    EMConnectionState _connectionState;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ZMHomeTabBarController *congTouHomeTabBarController;
@property (strong, nonatomic) MainViewController *mainController;


@end

