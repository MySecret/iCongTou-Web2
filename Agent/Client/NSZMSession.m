//
//  NSZMSession.m
//  zmkm
//
//  Created by bensonwang on 15/3/19.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import "NSZMSession.h"
#import "ZMUtils.h"

#define ZM_SESSION_KEY_USER @"_USER"
#define ZM_SESSION_KEY_STOCK_INDEXS @"_STOCK_INDEXS"
#define ZM_SESSION_KEY_STOCK_SEARCH @"_STOCK_SEARCHES"
#define ZM_SESSION_KEY_SYSTEM_INFO @"_SYSTEM_INFO"
#define ZM_SESSION_KEY_EXPERT @"_SYSTEM_EXPERT"

@implementation NSZMSession

+(NSZMSession*) sharedSession
{
    static NSZMSession *session = nil;
    if (!session) {
        session = [[super allocWithZone:nil] init];
        
    }

    return session;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedSession];
}

#pragma mark - Override Setter

- (void) setLoginUser:(ZMUser *)user
{
    _loginUser = user;
    [allObjects setObject:self.loginUser forKey:ZM_SESSION_KEY_USER];
    [self save];
}



#pragma mark - Basic
//从固化文件初始化对象
- (id)init
{
    self = [super init];
    if(self) {
        NSString *path = [self objectArchivePath];
        allObjects = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        self.showGuide = [[[NSUserDefaults standardUserDefaults] objectForKey:@"showGuide"] boolValue];
        if (allObjects) {
            _loginUser = [allObjects objectForKey:ZM_SESSION_KEY_USER];
        }else{
            allObjects = [[NSMutableDictionary alloc] initWithCapacity:0];
        }
    }
    return self;
}

//固化对象
- (BOOL)save
{
    NSString *path = [self objectArchivePath];
    return [NSKeyedArchiver archiveRootObject:allObjects toFile:path];
}


//对象固化路径
- (NSString *)objectArchivePath
{
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    NSString *path = @"zmsession.archive";
#ifdef DEBUG
    path = [NSString stringWithFormat:@"%@-%@",@"debug",path];
#endif
    
    return [documentDirectory stringByAppendingPathComponent:path];
}

#pragma mark - Common Interface
// 是否登录
-(BOOL) isLogin
{
    NSString* token = [self getToken];
    return ![ZMUtils isBlankString:token];
}

// 获取token
-(NSString*) getToken
{
    ZMUser* user = self.loginUser;
    if(user != nil && ![ZMUtils isBlankString:user.token]){
        return user.token;
    }
    return @"";
}

//-(NSNumber* ) loginId
//{
//    ZMUser* user = [self loginUser];
//    if(user != nil){
//        return user.id;
//    }
//    return [NSNumber numberWithInt:0];
//}

-(void) logout
{
    _loginUser = nil;
    [allObjects removeObjectForKey:ZM_SESSION_KEY_USER];
    [self save];
    
}

@end
