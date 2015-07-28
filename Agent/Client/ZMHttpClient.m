//
//  ZMHttpClient.m
//  zmkm
//
//  Created by bensonwang on 15/3/19.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import "ZMHttpClient.h"
#import "NSZMSession.h"
#import "ZMHttpClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "ZMUtils.h"

@implementation ZMHttpClient

#pragma mark - Basic HTTP
// 授权请求
+(void) sendWithAuth:(NSString*)url params:(NSMutableDictionary*)params ctr:(id<ZMHttpDelegate> ) ctr success:(void (^)(id obj,int total))_succ fail:(void (^)(int code,NSString *errorMsg)) _fail showLoading:(bool) showloading
{
    [self post:url params:params ctr:ctr file:nil success:_succ fail:_fail showLoading:showloading auth:true];
}

// 普通请求
+(void) send:(NSString*)url
      params:(NSMutableDictionary*)dic
         ctr:(id<ZMHttpDelegate> ) ctr
     success:(void (^)(id obj,int total))_succ
        fail:(void (^)(int code,NSString *errorMsg)) _fail
 showLoading:(bool) showloading
{
    [self post:url params:dic ctr:ctr file:nil success:_succ fail:_fail showLoading:showloading auth:false];
}

+(void) post:(NSString*)url
      params:(NSMutableDictionary*) dic
         ctr:(id<ZMHttpDelegate> ) ctr
        file:(NSData *)file
     success:(void (^)(id obj,int total))_succ
        fail:(void (^)(int code,NSString *errorMsg)) _fail
 showLoading:(bool) showloading
        auth:(bool) auth
{
    // 需要授权
    
    if (auth) {
        NSString* token = [SESSION getToken];
        [dic setObject:token forKey:@"token"];
    }
    NSString *_URL = [APIURL stringByAppendingString:url];
    
    // 添加通用请求参数
//    [dic setObject:[SESSION loginId] forKey:@"_u"];
    [dic setObject:ZM_VERSION forKey:@"_v"];
    [dic setObject:[NSString stringWithFormat:@"%d",ZM_OS_TYPE ]forKey:@"_o"];
       
    // 添加参数
    NSLog(@"【request】- [%@]",_URL);
    
    // 打开进度条
    if (showloading && ctr) {
        [ctr showLoading];
    }
    
    // 请求成功的回调
    void (^successBlock)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"【response-success】%@", responseObject);
        
        NSDictionary *d = responseObject;
        NSNumber *code = [d objectForKey:@"code"];
        NSString *msg = [d objectForKey:@"msg"];
        
        if ( ZM_RESPONSE_SUCCESS == code.intValue) {
            
            id data = [d objectForKey:@"data"];
            NSNumber *total = [d objectForKey:@"total"];
            
            if (_succ != nil) {
                _succ(data,total.intValue);
            }
            
        }else if ( ZM_RESPONSE_ERROR_TOKEN == code.intValue && ctr){
            
            [ctr notLogin];
        }else {
            
            if (_fail != nil) {
                _fail(-1,@"网络不给力");
            }else{
                // TODO Alert
                ALERT(msg)
            }
        }
        
        if (showloading) { // 关闭进度条
            [ctr dismissLoading];
        }
    };
    
    // 请求失败的回调
    void (^failureBlock)(AFHTTPRequestOperation*, NSError*) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【response-failure】%@", error);
        
        if (_fail != nil) {
            _fail(-1,@"网络不给力");
        }

        if (showloading && ctr) { // 关闭进度条
            [ctr dismissLoading];
        }
    };
    
    // 发送请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    if (file == nil ) { // 非文件上传
        [manager POST:_URL parameters:dic success:successBlock failure: failureBlock];
    }else {
        
        int random=arc4random_uniform(99999999);
        NSString *randomFileName = [NSString stringWithFormat:@"avatar_%d.jpg",random];
        [manager POST:_URL parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:file name:@"file" fileName:randomFileName mimeType:@"image/jpeg"];
        } success:successBlock failure:failureBlock];
    }
    
}

// 登陆
+(void) loginWithPhone:(NSString*) phone
              password:(NSString*) password
                   ctr:(id<ZMHttpDelegate>) ctr
               success:(void (^)(ZMUser* user))_succ
{
    NSLog(@"// 登陆 loginWithPhone %@ %@",phone,password);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:phone forKey:@"name"];
    [dic setObject:password forKey:@"password"];
    [ZMHttpClient send:@"/login.jhtml" params:dic ctr:ctr success:^(id obj,int total) {
        NSLog(@"%@",obj);
        ZMUser *user = [[ZMUser alloc] initWithDictionary:obj error:nil];
        [SESSION setLoginUser:user];
        _succ(user);
    } fail:nil showLoading:YES];
}


#pragma mark - User Api
// 获取正在接待的会话
+(void) getConverWithSuccess:(void (^)(NSArray *array,int total))_succ
                         ctr:(id<ZMHttpDelegate>) ctr;
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [ZMHttpClient post:@"/chat/conversations/online.jhtml" params:dic ctr:ctr file:nil success:^(id obj,int total) {
        NSLog(@"%@",obj);
        NSArray *jsonArray = obj;
        NSMutableArray *array = [ZMConversation arrayOfModelsFromDictionaries:jsonArray];
        _succ(array,total);
    } fail:nil showLoading:YES auth:YES];
 

}

// 获取等待接入的会话
+(void) getWaitingConverWithSuccess:(void (^)(NSArray *array,int total))_succ                         ctr:(id<ZMHttpDelegate>) ctr;
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"0" forKey:@"start"];
    [dic setValue:@"1000" forKey:@"size"];
    [ZMHttpClient post:@"/chat/conversations/wait.jhtml" params:dic ctr:ctr file:nil success:^(id obj,int total) {
//        NSLog(@"%@",obj);
        NSArray *jsonArray = obj;
        NSMutableArray *array = [WaitingConversation arrayOfModelsFromDictionaries:jsonArray];
        _succ(array,total);
    } fail:nil showLoading:YES auth:YES];
    
    
}

// 获取全部等待接入的会话数目
+(void) getWaitingConverNumWithSuccess:(void (^)(NSInteger num))_succ
                                   ctr:(id<ZMHttpDelegate>) ctr;
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [ZMHttpClient post:@"/chat/conversations/wait/count.jhtml" params:dic ctr:ctr file:nil success:^(id obj,int total) {
        NSLog(@"%@",obj);
        NSInteger num = [obj integerValue];
        _succ(num);
    } fail:nil showLoading:YES auth:YES];
}

// 关闭会话
+(void) closeConversation:(id<ZMHttpDelegate>) ctr
                  success:(void (^)(NSString* data))_succ
                      cid:(NSString *)cid;
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [ZMHttpClient post:@"/chat/conversations/close.jhtml" params:dic ctr:ctr file:nil success:^(id obj,int total) {
        NSLog(@"%@",obj);
        NSString* d = obj;
        _succ(d);
    } fail:nil showLoading:YES auth:YES];
}

// 打开会话
+(void) openConversation:(NSString* )cid ctr:(id<ZMHttpDelegate>) ctr
                 success:(void (^)(NSString *data))_succ;
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:cid forKey:@"cid"];
    [ZMHttpClient post:@"/chat/conversations/open.jhtml" params:dic ctr:ctr file:nil success:^(id obj,int total) {
        NSLog(@"%@",obj);
        NSString* d = obj;
        _succ(d);
    } fail:nil showLoading:YES auth:YES];
}


// 获取之前的历史消息
+(void) getHistoryMSGWithSuccess:(void (^)(NSArray *array,int total))_succ                                       ctr:(id<ZMHttpDelegate>) ctr
                             cid:(NSString *)cid;
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [ZMHttpClient post:@"/chat/messages/history.jhtml" params:dic ctr:ctr file:nil success:^(id obj,int total) {
        NSLog(@"%@",obj);
        NSArray *jsonArray = obj;
//        NSMutableArray *array = [ZMConversation arrayOfModelsFromDictionaries:jsonArray];
        _succ(jsonArray,total);
    } fail:nil showLoading:YES auth:YES];
}

@end
