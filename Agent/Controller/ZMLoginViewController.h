//
//  ZMLoginViewController.h
//  Agent
//
//  Created by 方浙徽 on 15/7/20.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ZMBaseViewController.h"
#import "AppDelegate.h"

@interface ZMLoginViewController : ZMBaseViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,UITabBarControllerDelegate>

{
    UITextField* nameField;
    UITextField* pswField;
}

@end
