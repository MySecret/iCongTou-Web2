//
//  ZMUser.h
//  Agent
//
//  Created by 方浙徽 on 15/7/20.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMUser : ZMBaseModel

@property (nonatomic, strong) NSString<Optional>* easeId;
@property (nonatomic, strong) NSString<Optional>* easePwd;
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *industrys;
//@property (nonatomic, strong) NSNumber *sex;
@property (nonatomic, strong) NSString *show_name;
@property (nonatomic, strong) NSString<Optional>*token;
@end
