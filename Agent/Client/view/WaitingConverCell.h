//
//  WaitingConverCell.h
//  Agent
//
//  Created by 方浙徽 on 15/7/27.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitingConversation.h"

@interface WaitingConverCell : UITableViewCell

{
    UILabel* nameLabel;
    UILabel* timeLabel;
}

@property (nonatomic, strong) UIButton* openBtn;


- (void)reloadViewWithItem:(WaitingConversation *)item;

@end
