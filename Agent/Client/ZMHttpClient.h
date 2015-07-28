//
//  ZMHttpClient.h
//  zmkm
//
//  Created by bensonwang on 15/3/19.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMUser.h"
#import "ZMConversation.h"
#import "WaitingConversation.h"
//#import "ZMExpert.h"

@protocol ZMHttpDelegate <NSObject>

// 未登录
-(void) notLogin;

// 打开加载条
-(void) showLoading;

// 关闭进度条
-(void) dismissLoading;

@end

@interface ZMHttpClient : NSObject

#pragma mark - Basic Request 
// 普通请求
+(void) send:(NSString*)url
      params:(NSMutableDictionary*)params
         ctr:(id<ZMHttpDelegate> ) ctr
     success:(void (^)(id obj,int total))_succ
        fail:(void (^)(int code,NSString *errorMsg)) _fail
 showLoading:(bool) showloading;

// 授权请求
+(void) sendWithAuth:(NSString*)url
              params:(NSMutableDictionary*)params
                 ctr:(id<ZMHttpDelegate> ) ctr
             success:(void (^)(id obj,int total))_succ
                fail:(void (^)(int code,NSString *errorMsg)) _fail
         showLoading:(bool) showloading;
#pragma mark - Stock Api
// 登陆
+(void) loginWithPhone:(NSString*) phone
                password:(NSString*) password
                     ctr:(id<ZMHttpDelegate>) ctr
                 success:(void (^)(ZMUser *user))_succ;


#pragma mark - User Api
// 获取正在接待的会话
+(void) getConverWithSuccess:(void (^)(NSArray *array,int total))_succ
                         ctr:(id<ZMHttpDelegate>) ctr;

// 获取等待接入的会话
+(void) getWaitingConverWithSuccess:(void (^)(NSArray *array,int total))_succ                         ctr:(id<ZMHttpDelegate>) ctr;

// 获取全部等待接入的会话数目
+(void) getWaitingConverNumWithSuccess:(void (^)(NSInteger num))_succ
                                   ctr:(id<ZMHttpDelegate>) ctr;

// 关闭会话
+(void) closeConversation:(id<ZMHttpDelegate>) ctr
           success:(void (^)(NSString* data))_succ
                      cid:(NSString *)cid;

// 打开会话
+(void) openConversation:(NSString* )cid ctr:(id<ZMHttpDelegate>) ctr
                 success:(void (^)(NSString *data))_succ;
// 获取之前的历史消息
+(void) getHistoryMSGWithSuccess:(void (^)(NSArray *array,int total))_succ                                       ctr:(id<ZMHttpDelegate>) ctr
            cid:(NSString *)cid;

@end
