//
//  NSZMSession.m
//  zmkm
//
//  Created by bensonwang on 15/3/19.
//  Copyright (c) 2015年 niusan. All rights reserved.
//

#import "NSZMSession.h"
#import "ZMUtils.h"
#import "APService.h"
#import <ShareSDK/ShareSDK.h>

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

- (void) setStockIndexs:(NSArray *)indexs
{
    _stockIndexs = indexs;
    [allObjects setObject:self.stockIndexs forKey:ZM_SESSION_KEY_STOCK_INDEXS];
    [self save];
}

- (void) setStockSearches:(NSMutableArray *)searches
{
    _stockSearches = searches;
    [allObjects setObject:self.stockSearches forKey:ZM_SESSION_KEY_STOCK_SEARCH];
    [self save];
}

- (void) setSystemInfo:(ZMSystemInfo *)info
{
    _systemInfo = info;
    [allObjects setObject:self.systemInfo forKey:ZM_SESSION_KEY_SYSTEM_INFO];
    [self save];
}

- (void) setExpertList:(NSMutableArray *)expertList
{
    _expertList = expertList;
    [allObjects setObject:self.expertList forKey:ZM_SESSION_KEY_EXPERT];
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
            _stockIndexs = [allObjects objectForKey:ZM_SESSION_KEY_STOCK_INDEXS];
            _stockSearches = [allObjects objectForKey:ZM_SESSION_KEY_STOCK_SEARCH];
            _systemInfo = [allObjects objectForKey:ZM_SESSION_KEY_SYSTEM_INFO];
            _expertList = [allObjects objectForKey:ZM_SESSION_KEY_EXPERT];
            if (([_loginUser.easeId isEqualToString:@""]||!_loginUser.easeId)&&_loginUser.id) {
                [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
                [self logout];
            }
        }else{
            allObjects = [[NSMutableDictionary alloc] init];
        }
        
        if (!self.stockSearches) {
            self.stockSearches = [[NSMutableArray alloc] init];
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
    if(user != nil && ![ZMUtils isBlankString:user.authentication_token]){
        return user.authentication_token;
    }
    return @"";
//    return @"EA9090B5EF026C837801C25A5154F523";
}

-(NSNumber* ) loginId
{
    ZMUser* user = [self loginUser];
    if(user != nil){
        return user.id;
    }
    return [NSNumber numberWithInt:0];
}

-(void) logout
{
    _loginUser = nil;
    [allObjects removeObjectForKey:ZM_SESSION_KEY_USER];
    [self save];
    
    [SESSION updateTagAndAlias];
}

-(void) updateTagAndAlias
{
    NSString *v = [NSString stringWithFormat:@"_v_%@",ZM_VERSION];
    NSString *o = [NSString stringWithFormat:@"_o_%d",ZM_OS_TYPE];
    
    NSMutableSet *tages = [[NSMutableSet alloc]initWithArray:@[v,o]];
    NSString *alias = [NSString stringWithFormat:@"_u_%d",SESSION.loginId.intValue];
    
#ifdef DEBUG
    alias = [NSString stringWithFormat:@"debug%@",alias];
    [tages addObject:@"debug"];
#endif
    
    [APService setTags:tages alias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

// 是否有提醒
-(BOOL) hasTips
{
    if (SESSION.isLogin) {
        return NO;
    }
    
    ZMTip *tip = SESSION.loginUser.tip;
    if (tip == nil) {
        return NO;
    }
    
    if (tip.congtoubao.integerValue > 0 || tip.messages.integerValue > 0) {
        return YES;
    }
    return NO;
}

-(ZMVersion *) hasVersion
{
    if (SESSION.systemInfo == nil) {
        return nil;
    }
    
    return  SESSION.systemInfo.version;
}

@end
