//
//  ZMUtils.m
//  zmkm
//
//  Created by bensonwang on 15/3/19.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMUtils.h"
#import "ZMBaseModel.h"

@implementation ZMUtils

+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (void) pushViewFrom:(UIViewController *) from to:(UIViewController *) to
{
    to.hidesBottomBarWhenPushed = true;
    from.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    from.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [from.navigationController pushViewController:to animated:YES];
}

+ (id)colorWithHex:(NSString *)hex
{
    NSAssert(7 == hex.length, @"Hex color format error!");
    
    unsigned color = 0;
    NSScanner *hexValueScanner = [NSScanner scannerWithString:[hex substringFromIndex:1]];
    [hexValueScanner scanHexInt:&color];
    
    int blue = color & 0xFF;
    int green = (color >> 8) & 0xFF;
    int red = (color >> 16) & 0xFF;
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (UIImageView *)makeImageViewCornerWithImageView:(UIImageView *)avatarImageView
{
    //圆角设置
    avatarImageView.layer.cornerRadius = 5;//(值越大，角就越圆)
    avatarImageView.layer.masksToBounds = YES;
    //边框宽度及颜色设置
    [avatarImageView.layer setBorderWidth:2];
    [avatarImageView.layer setBorderColor:(__bridge CGColorRef)([UIColor blueColor])];  //设置边框为蓝色
    //自动适应,保持图片宽高比
    avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return avatarImageView;
}

+(CGSize)sizeWithString:(NSString *) string Font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+(UIButton *) radiusButtonWithFrame:(CGRect) frame Title : (NSString *) title{
    UIButton *loginButton = [[UIButton alloc]initWithFrame:frame];
    loginButton.hidden = NO;
    loginButton.backgroundColor = CustomRedColor;
    loginButton.layer.masksToBounds= YES;
    loginButton.layer.cornerRadius =  4;
    [loginButton setTitle:title forState:UIControlStateNormal];
    return loginButton;
}

+(void)turn2appleStore
{
    NSString *urlString = @"https://itunes.apple.com/us/app/cong-tou-da-shu-ju-chao-gu/id923199963?mt=8";
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
}

+ (NSString *)md5Str:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//验证手机号是否合法
+(BOOL)isValidateMobile:(NSString *)mobile
{
    //此为手机
    NSString *phoneRegex1 =  @"^.{11}$";
    //    NSString *phoneRegex = @"^((0(10|2[1-3]|[3-9]\\d{2}))?[1-9]\\d{6,7})|((13[0-9])|(14[0,0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";//此为手机或者固话
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return [phoneTest evaluateWithObject:mobile];
}
+ (UIImage *) imageNamed:(NSString *) imageName
{
    NSRange sr = [imageName rangeOfString:@"."];
    NSRange fr = NSMakeRange(0, sr.location);
    NSString *fn = [imageName substringWithRange:fr];
    NSString *ext = [imageName substringFromIndex:sr.location+1];
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x", fn] ofType:ext];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    return img;
}

+ (NSString*)nsdateToString:(NSDate*)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    [dateFormatter setDateFormat:@"MM-dd hh:mm:ss"];
    NSString* datestring = [dateFormatter stringFromDate:date];
    return datestring;
}

@end
