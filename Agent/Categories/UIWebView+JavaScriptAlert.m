//
//  UIWebView+JavaScriptAlert.m
//  zmkm
//
//  Created by LiBinggen on 15/1/19.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"
#import "ZMTapGestureRecognizer.h"

@implementation UIWebView (JavaScriptAlert)
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)webFrame {
     UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(performDismiss:) userInfo:dialogue repeats:YES];
     [dialogue show];
//    [self showTips:message];
    
}

- (void) performDismiss: (NSTimer *)timer {
    UIAlertView *dialogue = (UIAlertView*)[timer userInfo];
    [dialogue dismissWithClickedButtonIndex:0 animated:NO];//important
    dialogue = NULL;
}

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame{
//    UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
//    [dialogue show];
    
    [self showTips:message];
    
    return NO;
}

- (NSString *) webView:(UIWebView *)view runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)text initiatedByFrame:(CGRect *)frame{
//    UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:nil message:prompt delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
//    [dialogue show];
    
    [self showTips:prompt];
    
    return prompt;
}

- (void)showTips:(NSString *)message
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];//获取窗口大小
    UIView *theView = [[UIView alloc] initWithFrame:frame];//实例一个UIView
    theView.backgroundColor = [UIColor blackColor];//设置其背景色为黑色
    theView.alpha = 0.9;//设置其透明为0.7
    CGRect labelFrame = CGRectMake(10, 10, 300, 400);
    UILabel *waitingLable = [[UILabel alloc] initWithFrame:labelFrame];
    waitingLable.text = message;
    waitingLable.textColor = [UIColor whiteColor];
    waitingLable.font = [UIFont systemFontOfSize:13];
    waitingLable.backgroundColor = [UIColor clearColor];
    waitingLable.numberOfLines = 0;
    waitingLable.hidden = NO;
    waitingLable.textAlignment = NSTextAlignmentCenter;
    
    [theView addSubview:waitingLable];
    ZMTapGestureRecognizer *recognizerTap = [[ZMTapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(dismiss:)];
    [recognizerTap setNumberOfTapsRequired:1];
    recognizerTap.cancelsTouchesInView = NO;
    recognizerTap.tapView = theView;
    [theView addGestureRecognizer:recognizerTap];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:theView];
}

- (void)dismiss:(UITapGestureRecognizer *)sender {
    NSLog(@"Debug1\n dismiss");
    ZMTapGestureRecognizer *tapG = (ZMTapGestureRecognizer *)sender;
    [tapG.tapView removeFromSuperview];

}

@end
