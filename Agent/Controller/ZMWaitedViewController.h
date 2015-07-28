//
//  ZMWaitedViewController.h
//  Agent
//
//  Created by 方浙徽 on 15/7/23.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ZMBaseViewController.h"

@interface ZMWaitedViewController : ZMBaseViewController<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tableView;
    NSMutableArray* _dataArray;
}


@end
