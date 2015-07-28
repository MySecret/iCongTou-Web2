//
//  ZMSettingViewController.m
//  Agent
//
//  Created by 方浙徽 on 15/7/23.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ZMSettingViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ZMLoginViewController.h"
@interface ZMSettingViewController ()
{
    UIImageView* headView;
    UILabel* nameLabel;
    UILabel* areaLabel;
    UIButton* logout;
}
@end
#define HEAD_SIZE 50

@implementation ZMSettingViewController

- (void)doViewDidLoad
{
    self.title = @"设置";
    self.view.backgroundColor = COLOR_WITH_HEX(0xeeeeee);
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    headView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, HEAD_SIZE, HEAD_SIZE)];
    headView.backgroundColor = COLOR_WITH_HEX(0xeeeeee);
    [headView setImageWithURL:[NSURL URLWithString:SESSION.loginUser.avatar]];
    [bgView addSubview:headView];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(HEAD_SIZE+30, 25, SCREEN_WIDTH-HEAD_SIZE-40, 15)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = COLOR_WITH_HEX(0x6f6f6f);
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = SESSION.loginUser.show_name;
    [bgView addSubview:nameLabel];
    areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(HEAD_SIZE+30, 100-25-15, SCREEN_WIDTH-HEAD_SIZE-40, 15)];
    areaLabel.backgroundColor = [UIColor clearColor];
    areaLabel.textColor = COLOR_WITH_HEX(0x6f6f6f);
    areaLabel.font = [UIFont systemFontOfSize:12];
    areaLabel.text = SESSION.loginUser.industrys;
    [bgView addSubview:areaLabel];
    logout = [UIButton buttonWithType:UIButtonTypeCustom];
    logout.backgroundColor = [UIColor greenColor];
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    [logout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logout.titleLabel.font = [UIFont systemFontOfSize:15];
    [logout addTarget:self action:@selector(onClickLogout:) forControlEvents:UIControlEventTouchUpInside];
    logout.frame = CGRectMake(10, SCREEN_HEIGHT-49-40-NavigationBar_HEIGHT-20-40, SCREEN_WIDTH-20, 40);
    [self.view addSubview:logout];
    

}
- (void)onClickLogout:(UIButton *)btn
{
//    [SESSION logout];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (error && error.errorCode != EMErrorServerNotLogin) {
        }
        else{
        }
    } onQueue:nil];
    AppDelegate* del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    ZMLoginViewController* ctr = [[ZMLoginViewController alloc] init];
    del.window.rootViewController = ctr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [headView setImageWithURL:[NSURL URLWithString:SESSION.loginUser.avatar]];
    nameLabel.text = SESSION.loginUser.show_name;
    areaLabel.text = SESSION.loginUser.industrys;
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
