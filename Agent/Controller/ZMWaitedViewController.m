//
//  ZMWaitedViewController.m
//  Agent
//
//  Created by 方浙徽 on 15/7/23.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ZMWaitedViewController.h"
#import "WaitingConverCell.h"

@interface ZMWaitedViewController ()

@end

@implementation ZMWaitedViewController

- (void)doViewDidLoad
{
    self.title = @"待接入";
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
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
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaitingConverCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"waiting"];
    if (!cell) {
        cell = [[WaitingConverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"waiting"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WaitingConversation* item = [_dataArray objectAtIndex:indexPath.row];
    [cell reloadViewWithItem:item];
    [cell.openBtn addTarget:self action:@selector(onClickOpen:) forControlEvents:UIControlEventTouchUpInside];
    cell.openBtn.tag = 1000+indexPath.row;
    return cell;
}
- (void)onClickOpen:(UIButton *)btn
{
    WaitingConversation* item = [_dataArray objectAtIndex:btn.tag-1000];
    [ZMHttpClient openConversation:item.id ctr:self success:^(NSString* str){
        [_dataArray removeObject:item];
        [_tableView reloadData];
    }];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [ZMHttpClient getWaitingConverWithSuccess:^(NSArray* array,int total){
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:array];
        [_tableView reloadData];
    } ctr:self];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
