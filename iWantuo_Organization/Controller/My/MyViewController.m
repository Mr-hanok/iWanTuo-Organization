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
#import "StudentListViewController.h"
#import "MyMessageViewController.h"
#import "ApiLoginOutRequest.h"
#import "SystemHandler.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (nonatomic, strong) ApiLoginOutRequest *apiLoginOut;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MyViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";

//    __weak typeof(self) weakSelf = self;
//    [self setRightBtnImage:[UIImage imageNamed:@"setting"] eventHandler:^(id sender) {
//        SettingViewController *vc = [[SettingViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [weakSelf.navigationController pushViewController:vc animated:YES];
//    }];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview reloadData];
    [MobClick beginLogPageView:@"我的"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"我的"];
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
    [AccountManager sharedInstance].account.isLogin = @"no";
    [[AccountManager sharedInstance] saveAccountInfoToDisk];
    [HUDManager showWarningWithText:@"退出登录成功"];
    kRootViewController = [SystemHandler rootViewController];

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
    return 8;
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
        [cell1.headIV sd_setImageWithURL:[NSURL URLWithString:[AccountManager sharedInstance].account.headPortrait] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
        cell1.acountLabel.text = [AccountManager sharedInstance].account.loginAccounts;
        if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {
            cell1.userNameLabel.text = [AccountManager sharedInstance].account.name;
        } else {
            NSLog(@"%@",[AccountManager sharedInstance].account.organizationAbbreviation);
            cell1.userNameLabel.text = [AccountManager sharedInstance].account.organizationAbbreviation;
        }

        return cell1;
    } else {
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

    BaseViewController *vc = nil;
    switch (indexPath.row) {
            
        case 0://基本信息
            if ([self limitAccountType]) {
                vc = [[PersonDetailController alloc]init];
            }
            break;
        case 1://每日跟踪
            //if ([self limitAccountType]) {
                vc = [[MyFollowViewController alloc]init];
           // }
            
            break;
        case 3://我的消息
//            if ([self limitAccountType]) {
            vc = [[MyMessageViewController alloc]init];
//            }
            break;
        case 2://学生管理
            if ([self limitAccountType]) {
                vc = [[StudentListViewController alloc]init];
            }
            break;
        case 4://班级管理
            if ([self limitAccountType]) {
                vc = [[MyClassViewController alloc]init];
            }
            break;
        case 5://班主任管理
            if ([self limitAccountType]) {
                vc = [[MyClassTeacherViewController alloc]init];
            }
            break;
        case 6://推送消息
            if ([self limitAccountType]) {
                vc = [[MyPushMessageViewController alloc]init];
            }
            break;
        case 7:
            vc = [[SettingViewController alloc] init];
            break;

    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - event response
/**
 *  退出按钮
 */
- (IBAction)Logout:(UIButton *)sender {
    
//    if ([[AccountManager sharedInstance].account.isLogin isEqualToString:@"no"] ||[[ValueUtils stringFromObject:[AccountManager sharedInstance].account.isLogin] isEqualToString:@""]) {
//        [HUDManager showWarningWithText:@"尚未登录"];
//        return;
//    }
    [AlertViewManager showAlertViewMessage:@"确定要退出登录吗" handlerBlock:^{
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
- (BOOL)limitAccountType{
    if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {
        [HUDManager showWarningWithText:@"您没有权限操作！"];
        return NO;
        
    }else {
        return YES;
    }
}
@end
