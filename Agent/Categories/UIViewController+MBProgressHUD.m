//
//  UIViewController+MBProgressHUD.m
//  zmkm
//
//  Created by LiBinggen on 15/1/16.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import "UIViewController+MBProgressHUD.h"

@implementation UIViewController (MBProgressHUD)

- (void)showLoading:(UIView *)aView {
    if ([MBProgressHUD allHUDsForView:aView].count > 0) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:aView animated:YES];
}

- (void)hideLoading:(UIView *)aView {
    [MBProgressHUD hideAllHUDsForView:aView animated:YES];
}

@end
