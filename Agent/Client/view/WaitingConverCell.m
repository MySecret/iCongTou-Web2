//
//  WaitingConverCell.m
//  Agent
//
//  Created by 方浙徽 on 15/7/27.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "WaitingConverCell.h"
#import "ZMUtils.h"

@implementation WaitingConverCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 15)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = COLOR_WITH_HEX(0x3d3d3d);
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:nameLabel];
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50-20, SCREEN_WIDTH-20, 15)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = COLOR_WITH_HEX(0x8e8e8e);
        timeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:timeLabel];
        self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.openBtn.frame = CGRectMake(SCREEN_WIDTH-10-60, 10, 60, 30);
        self.openBtn.backgroundColor = [UIColor greenColor];
        [self.openBtn setTitle:@"接入" forState:UIControlStateNormal];
        [self.openBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.openBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.openBtn];
        UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = COLOR_WITH_HEX(0x9f9f9f);
        [self addSubview:line];
    }
    return self;
}

- (void)reloadViewWithItem:(WaitingConversation *)item
{
    nameLabel.text  = [item.user objectForKey:@"show_name"];
    timeLabel.text = [ZMUtils nsdateToString:[NSDate dateWithTimeIntervalSince1970:item.updateTime.longLongValue]];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
