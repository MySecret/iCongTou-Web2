//
//  ZMLoginViewController.m
//  Agent
//
//  Created by 方浙徽 on 15/7/20.
//  Copyright (c) 2015年 fzh. All rights reserved.
//

#import "ZMLoginViewController.h"
#import "NSZMSession.h"


@interface ZMLoginViewController ()

@end

@implementation ZMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_WITH_HEX(0xeeeeee);
    UILabel* t1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50,SCREEN_WIDTH, 40)];
    t1.backgroundColor = CLEARCOLOR;
    t1.textColor = COLOR_WITH_HEX(0x3d3d3d);
    t1.text = @"聪头客服";
    t1.font = [UIFont boldSystemFontOfSize:23];
    t1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:t1];
    UILabel* t2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH, 30)];
    t2.backgroundColor = CLEARCOLOR;
    t2.textColor = COLOR_WITH_HEX(0x3d3d3d);
    t2.text = @"聪明你的投资";
    t2.font = [UIFont systemFontOfSize:12];
    t2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:t2];
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 80)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    NSArray* array = [NSArray arrayWithObjects:@"账号:",@"密码:", nil];
    NSArray* array1 = [NSArray arrayWithObjects:@"客服账号",@"密码", nil];
    for (int i = 0; i < 2; i++) {
        UILabel* tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*i, 60, 40)];
        tLabel.backgroundColor = CLEARCOLOR;
        tLabel.textColor = COLOR_WITH_HEX(0x3d3d3d);
        tLabel.text = [array objectAtIndex:i];
        tLabel.textAlignment = NSTextAlignmentRight;
        tLabel.font = [UIFont systemFontOfSize:15];
        [bgView addSubview:tLabel];
        UITextField* field = [[UITextField alloc] initWithFrame:CGRectMake(70, 40*i, SCREEN_WIDTH, 40)];
        field.returnKeyType = UIReturnKeyNext;
        field.autocapitalizationType = UITextAutocapitalizationTypeNone;
        field.keyboardType = UIKeyboardTypeEmailAddress;
        field.font = [UIFont systemFontOfSize:14];
        field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        field.textColor = COLOR_WITH_HEX(0x3d3d3d);
        field.delegate = self;
        field.placeholder = [array1 objectAtIndex:i];
        [bgView addSubview:field];
        if (i == 0) {
            UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = COLOR_WITH_HEX(0x6f6f6f);
            [bgView addSubview:line];
            
            field.text = [NSString stringWithFormat:@"%@",SESSION.loginUser.uid];
            NSLog(@"%@,%@,%@", SESSION.loginUser.easeId,SESSION.loginUser.easePwd,SESSION.loginUser.show_name);
            nameField = field;
        }else{
            field.text = SESSION.loginUser.easePwd;
            pswField = field;
        }
    }
    UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleToFitHomeView:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    UIButton* logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logBtn.frame = CGRectMake(10, bgView.frame.size.height+bgView.frame.origin.y+20, SCREEN_WIDTH-20, 40);
    logBtn.backgroundColor = [UIColor greenColor];
    [logBtn setTitle:@"登录" forState:UIControlStateNormal];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [logBtn addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logBtn];
}
- (void)onClickLogin:(UIButton *)btn
{
    NSString* name = nameField.text;
    NSString* psw = pswField.text;
    [ZMHttpClient loginWithPhone:name password:psw ctr:self success:^(ZMUser *user){
    
        
        [SESSION setLoginUser:user];
//        异步登陆账号
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user.easeId
                                                            password:user.easePwd
                                                          completion:
         ^(NSDictionary *loginInfo, EMError *error) {
             //             [self hideHud];
             if (loginInfo && !error) {
                 [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                 //                 //发送自动登陆状态通知
                 //                 [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                 //将旧版的coredata数据导入新的数据库
                 EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
                 if (!error) {
                     error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                 }
             }else {
                 NSLog(@"%@",error);
                 switch (error.errorCode) {
                     case EMErrorServerNotReachable:
                         TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                         break;
                     case EMErrorServerAuthenticationFailure:
                         TTAlertNoTitle(error.description);
                         break;
                     case EMErrorServerTimeout:
                         TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                         break;
                     default:
                         TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Logon failure"));
                         break;
                 }
             }
         } onQueue:nil];
        AppDelegate* del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        del.window.rootViewController = del.congTouHomeTabBarController;
    }];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == nameField) {
        [nameField resignFirstResponder];
        [pswField becomeFirstResponder];
    }else{
        [pswField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark -  Gesture Handle
//背景单击事件
-(void)handleToFitHomeView:(id)sender
{
    [nameField resignFirstResponder];
    [pswField resignFirstResponder];
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
