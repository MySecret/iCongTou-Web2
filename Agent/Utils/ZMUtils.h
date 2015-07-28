//
//  ZMUtils.h
//  zmkm
//
//  Created by bensonwang on 15/3/19.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMBaseViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface ZMUtils : NSObject

// 判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;

+ (void) pushViewFrom:(UIViewController *) from to:(UIViewController *) to;

+ (id) colorWithHex:(NSString *)hex ;

+ (UIViewController *)getCurrentVC;

// 图片圆角处理
+ (UIImageView *)makeImageViewCornerWithImageView:(UIImageView *)avatarImageView;

+(CGSize)sizeWithString:(NSString *) string Font:(UIFont *)font maxSize:(CGSize)maxSize;

+(UIButton *) radiusButtonWithFrame:(CGRect) frame Title : (NSString *) title;

+(void) turn2appleStore;
//MD5加密
+ (NSString *)md5Str:(NSString *)str;
//验证手机号是否合法
+(BOOL)isValidateMobile:(NSString *)mobile;
+ (UIImage *) imageNamed:(NSString *) imageName;
+ (NSString*)nsdateToString:(NSDate*)date;

@end
