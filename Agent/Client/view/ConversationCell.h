//
//  ConversationCell.h
//  Agent
//
//  Created by 方浙徽 on 15/7/27.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMConversation.h"

@interface ConversationCell : UITableViewCell

{
    UIImageView* headView;
    UILabel* nameLabel;
    UILabel* timeLabel;
    UILabel* contentLabel;
    UILabel* line;
}


- (void)reloadViewWithItem:(ZMConversation *)item;

































@end
