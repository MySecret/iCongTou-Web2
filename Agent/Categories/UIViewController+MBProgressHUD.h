//
//  UIViewController+MBProgressHUD.h
//  zmkm
//
//  Created by LiBinggen on 15/1/16.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef void(^DoBlock)(void);

@interface UIViewController (MBProgressHUD)

- (void)showLoading:(UIView *)aView;

- (void)hideLoading:(UIView *)aView;

@end
