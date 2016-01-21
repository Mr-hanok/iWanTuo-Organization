//
//  MyViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/6.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyViewController.h"
#import "MyCell.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "PersonDetailController.h"
#import "MyFollowViewController.h"
#import "MyClassViewController.h"
#import "MyClassTeacherViewController.h"
#import "MyPushMessageViewController.h"
#import "MyStudentViewController.h"
#import "MyMessageViewController.h"
#import "ApiLoginOutRequest.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (nonatomic, strong) ApiLoginOutRequest *apiLoginOut;

@end

@implementation MyViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";

    __weak typeof(self) weakSelf = self;
    [self setRightBtnImage:[UIImage imageNamed:@"home_unSelect"] eventHandler:^(id sender) {
        SettingViewController *vc = [[SettingViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [MobClick beginLogPageView:@"我的"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"我的"];
    self.tabBarController.tabBar.hidden = YES;

}

#pragma mark -  APIRequestDelegate

- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    
    [HUDManager hideHUDView];
    
    [AlertViewManager showAlertViewWithMessage:kDefaultNetWorkErrorString];
    
}

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {
    
    [HUDManager hideHUDView];
    
    if (sr.dic == nil || [sr.dic isKindOfClass:[NSNull class]]) {
        return;
    }
    
    //保存用户信息
    AccountModel *model =[AccountManager sharedInstance].account;
    model.isLogin = @"no";
    [[AccountManager sharedInstance] saveAccountInfoToDisk];
    LoginViewController *vc = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    [HUDManager showWarningWithText:@"退出登陆成功"];

}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {
    
    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myCell = @"MyCell";
    static NSString *myTypeCell = @"MyTypeCell";
    
    MyCell *cell1 = [tableView dequeueReusableCellWithIdentifier:myCell];
    MyCell *cell2 = [tableView dequeueReusableCellWithIdentifier:myTypeCell];
    if (indexPath.row == 0) {
        if (!cell1) {
            cell1 = [MyCell shareMyCell];
        }
        
        return cell1;
    }else {
        if (!cell2) {
            cell2 = [MyCell shareMyTypeCell];
        }
        cell2.row = indexPath.row;
        
        return cell2;
    }
}

#pragma mark - UITableViewDelegate

/**
 *  设置cell高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }
    return kTableViewCellHeightText;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断是否登陆
    if ([[AccountManager sharedInstance].account.isLogin isEqualToString:@"no"] ||[[ValueUtils stringFromObject:[AccountManager sharedInstance].account.isLogin] isEqualToString:@""]) {
        [AlertViewManager showAlertViewMessage:@"尚未登陆,请登录!" handlerBlock:^{
            LoginViewController *vc = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        return;
    }
    
    BaseViewController *vc = nil;
    switch (indexPath.row) {
            
        case 0://基本信息
            [self limitAccountType];
            vc = [[PersonDetailController alloc]init];
            break;
        case 1://每日跟踪
            vc = [[MyFollowViewController alloc]init];
            break;
        case 3://我的消息
            [self limitAccountType];
            vc = [[MyMessageViewController alloc]init];
            break;
        case 2://学员管理
            [self limitAccountType];
            vc = [[MyStudentViewController alloc]init];
            break;
        case 4://班级管理
            [self limitAccountType];
            vc = [[MyClassViewController alloc]init];
            break;
        case 5://班主任管理
            [self limitAccountType];
            vc = [[MyClassTeacherViewController alloc]init];
            break;
        case 6://推送消息
            [self limitAccountType];
            vc = [[MyPushMessageViewController alloc]init];
            break;

    }
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - event response
/**
 *  退出按钮
 */
- (IBAction)Logout:(UIButton *)sender {
    
    if ([[AccountManager sharedInstance].account.isLogin isEqualToString:@"no"] ||[[ValueUtils stringFromObject:[AccountManager sharedInstance].account.isLogin] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"尚未登陆"];
        return;
    }
    [AlertViewManager showAlertViewMessage:@"确定要退出登陆吗" handlerBlock:^{
        self.apiLoginOut = [[ApiLoginOutRequest alloc]initWithDelegate:self];
        [self.apiLoginOut setApiParams];
        [APIClient execute:self.apiLoginOut];
        [HUDManager showLoadingHUDView:self.view];
        
    }];
}

#pragma mark - private methods
/**
 *  判断是否有权限操作
 */
- (void)limitAccountType{
    BOOL accountType =[[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"];
    if (accountType) {
        [HUDManager showWarningWithText:@"您没有权限操作！"];
        return;
    }
}
@end
