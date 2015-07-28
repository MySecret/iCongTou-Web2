//
//  ZMBaseViewController.h
//  zmkm
//
//  Created by bensonwang on 15/3/17.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMHttpClient.h"
#import "NSZMSession.h"
//#import "ZMShareInfo.h"
#import "ZMUtils.h"
#import "UINavigationController+SGProgress.h"
//#import "BDWalletSDKMainManager.h"

@interface ZMBaseViewController : UIViewController<ZMHttpDelegate,UIAlertViewDelegate>

- (void) doViewDidLoad;

// 设置分享
//- (void) share:(ZMShareInfo *)shareData;

// alert
- (void) alert:(NSString *)message;

// 跳转
- (void) pushViewController:(UIViewController *) to;

// 跳转 - 需登陆
- (void) pushViewControllerWithAuth:(UIViewController *) to;

// 清除单元格内容
- (void) cleanCell:(UITableViewCell *)cell;

// 获取可见内容区域
- (CGRect) getContentViewFrame;

// 去支付
//- (void) pay:(NSString *) orderInfo;

@end