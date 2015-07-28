//
//  NSZMSession.h
//  zmkm
//
//  Created by bensonwang on 15/3/19.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMUser.h"
#import "ZMSystemInfo.h"

@interface NSZMSession : NSObject
{
    NSMutableDictionary *allObjects;
}
@property (nonatomic, strong) NSMutableArray *expertList;       // 专家列表
@property (nonatomic, strong) ZMUser *loginUser;                // 登陆用户数据
@property (nonatomic, strong) NSArray *stockIndexs;             // 大盘指数
@property (nonatomic, strong) NSMutableArray *stockSearches;    // 搜索历史
@property (nonatomic, strong) ZMSystemInfo * systemInfo;        // 系统信息
@property BOOL showGuide;
// 全局会话
+(NSZMSession*) sharedSession;

// 固化
-(BOOL) save;

// 是否登录
-(BOOL) isLogin;

// 获取token
-(NSString*) getToken;

// 登录用户id
-(NSNumber*) loginId;

// 退出登录，清除用户信息
-(void) logout;

// 更新Push
-(void) updateTagAndAlias;

// 是否有新提醒
-(BOOL) hasTips;

// 是否有新版本
-(ZMVersion *) hasVersion;

@end
