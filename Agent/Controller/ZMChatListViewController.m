//
//  ZMChatListViewController.m
//  Agent
//
//  Created by 方浙徽 on 15/7/23.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ZMChatListViewController.h"
#import "ConversationCell.h"
#import "ChatViewController.h"

@interface ZMChatListViewController ()

@end

@implementation ZMChatListViewController

- (void)doViewDidLoad
{
    self.title = @"会话";
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConversationCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"conversasion"];
    if (!cell) {
        cell = [[ConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"conversasion"];
        cell.backgroundColor = [UIColor whiteColor];
    }
    ZMConversation* item = [_dataArray objectAtIndex:indexPath.row];
    
    [cell reloadViewWithItem:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMConversation* item = [_dataArray objectAtIndex:indexPath.row];
    // 可选
    ChatViewController *chatController;
    NSString *title = item.userName;
    NSString *chatter = item.easeName;
    chatController = [[ChatViewController alloc] initWithChatter:chatter isGroup:NO];
    chatController.title = title;
    [self pushViewController:chatController];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [ZMHttpClient getConverWithSuccess:^(NSArray* array,int total){
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:array];
        [_tableView reloadData];
    } ctr:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
