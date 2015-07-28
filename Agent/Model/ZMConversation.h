//
//  ZMConversation.h
//  Agent
//
//  Created by 方浙徽 on 15/7/27.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMConversation : ZMBaseModel

@property (nonatomic, strong) NSString<Optional>* id;
@property (nonatomic, strong) NSString<Optional>* lastMessage;
@property (nonatomic, strong) NSString<Optional>* userName;
@property (nonatomic, strong) NSString<Optional>* easeName;
@property (nonatomic, strong) NSString<Optional>* avatar;
@property (nonatomic, strong) NSNumber<Optional>* lastMessageTime;

@end
