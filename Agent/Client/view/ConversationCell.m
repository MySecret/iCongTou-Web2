//
//  ConversationCell.m
//  Agent
//
//  Created by 方浙徽 on 15/7/27.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ConversationCell.h"
#import "UIImageView+AFNetworking.h"
#import "ZMUtils.h"

@implementation ConversationCell


#define HEAD_SIZE 35

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        headView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, HEAD_SIZE, HEAD_SIZE)];
        headView.backgroundColor = COLOR_WITH_HEX(0xeeeeee);
        [self addSubview:headView];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(HEAD_SIZE+20, 10, SCREEN_WIDTH-30-HEAD_SIZE, 15)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = COLOR_WITH_HEX(0x3d3d3d);
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:nameLabel];
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(HEAD_SIZE+20, 10, SCREEN_WIDTH-30-HEAD_SIZE, 15)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = COLOR_WITH_HEX(0x8e8e8e);
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:timeLabel];
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(HEAD_SIZE+20, HEAD_SIZE-5, SCREEN_WIDTH-30-HEAD_SIZE, 15)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = COLOR_WITH_HEX(0x6f6f6f);
        contentLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:contentLabel];
        line = [[UILabel alloc] initWithFrame:CGRectMake(10, HEAD_SIZE+20-0.5, SCREEN_WIDTH-10, 0.5)];
        line.backgroundColor = COLOR_WITH_HEX(0x9f9f9f);
        [self addSubview:line];
        
    }
    return self;
}

- (void)reloadViewWithItem:(ZMConversation *)item
{
    [headView setImageWithURL:[NSURL URLWithString:item.avatar]];
    nameLabel.text  = item.userName;
    timeLabel.text = [ZMUtils nsdateToString:[NSDate dateWithTimeIntervalSince1970:item.lastMessageTime.longLongValue]];
    contentLabel.text = item.lastMessage;
    
}







- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




























@end
