//
//  ZMBaseViewController.m
//  zmkm
//
//  Created by bensonwang on 15/3/17.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import "ZMBaseViewController.h"
#import "MBProgressHUD.h"

@interface ZMBaseViewController ()

@end

@implementation ZMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self doViewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) doViewDidLoad {
}


// 未登录

- (void) alert:(NSString *)message
{
    UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:nil message:@"网络不给力" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(performDismiss:) userInfo:dialogue repeats:YES];
    [dialogue show];
}

- (void) performDismiss: (NSTimer *)timer {
    UIAlertView *dialogue = (UIAlertView*)[timer userInfo];
    [dialogue dismissWithClickedButtonIndex:0 animated:NO];//important
    dialogue = NULL;
}

// 打开加载条
-(void) showLoading
{
    if ([MBProgressHUD allHUDsForView:self.view].count > 0) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

// 关闭进度条
-(void) dismissLoading
{
   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void) pushViewController:(UIViewController *) to
{
    to.hidesBottomBarWhenPushed = true;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationController pushViewController:to animated:YES];
}

- (void) pushViewControllerWithAuth:(UIViewController *) to
{
    [self pushViewController:to];
    return;
}

//清除单元格内容
- (void)cleanCell:(UITableViewCell *)cell
{
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
}

- (CGRect) getContentViewFrame;
{
    CGRect rect = [ UIScreen mainScreen ].bounds;
    int navheight = self.navigationController.navigationBar.frame.size.height;
    int tabheight = self.tabBarController.tabBar.frame.size.height;
    int statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    if(self.hidesBottomBarWhenPushed == NO){
        return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - navheight - tabheight -statusBarHeight);
    }else{
        return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - navheight -statusBarHeight);
    }
}


-(void)BDWalletPayResultWithCode:(int)statusCode payDesc:(NSString*)payDesc;
{
    NSLog(@"支付结束 接口 code:%d desc:%@",statusCode,payDesc);
//    NSString* msg;
//    if(statusCode == 0){
//        msg = @"支付成功";
//    }else{
//        msg = @"支付失败";
//    }
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//    [alert show];
//    [[NSNotificationCenter defaultCenter] postNotificationName:PAYOUT object:nil];
}

- (void)logEventId:(NSString*)eventId eventDesc:(NSString*)eventDesc;
{

}





@end
