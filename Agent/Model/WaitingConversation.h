//
//  WaitingConversation.h
//  Agent
//
//  Created by 方浙徽 on 15/7/27.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ZMBaseModel.h"

@interface WaitingConversation : ZMBaseModel

@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* updateTime;
@property (nonatomic, strong) NSDictionary* user;

@end
