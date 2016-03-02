//
//  SettingViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/14.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "SettingViewController.h"
#import "MyCell.h"
#import "FeedbackViewController.h"
#import "ChangePasswordController.h"
#import "AboutViewController.h"
#import "ApiLoginOutRequest.h"
#import "SystemHandler.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ApiLoginOutRequest *apiLoginOut;
@end

@implementation SettingViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myTypeCell = @"MyTypeCell";
    
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:myTypeCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:0]lastObject];
    }
    switch (indexPath.row) {
        case 0:
            cell.typeLabel.text = @"修改密码";
            cell.typeIV.image = [UIImage imageNamed:@""];
            break;
        case 1:
            cell.typeLabel.text = @"意见反馈";
            cell.typeIV.image = [UIImage imageNamed:@""];
            break;
        case 2:
            cell.typeLabel.text = @"关于爱晚托";
            cell.typeIV.image = [UIImage imageNamed:@""];
            break;

    }
    cell.imageWithConstran.constant = 1.f;
    cell.typeLeftConstran.constant = 1.f;
    return cell;
    
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


#pragma mark - UITableViewDelegate

/**
 *  设置cell高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellHeightText;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseViewController *vc = nil;
    switch (indexPath.row) {
        case 0://修改密码
        {
//            if ([AccountManager sharedInstance].isLogin == NO) {
//                [HUDManager showWarningWithText:@"尚未登录."];
//                return;
//            }
            vc = [[ChangePasswordController alloc]init];
        }
            
            break;
        case 1://意见反馈
            vc = [[FeedbackViewController alloc]init];
            break;
        case 2://关于爱晚托
            vc = [[AboutViewController alloc]init];
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - event response
/**
 *  退出按钮
 */
- (IBAction)Logout:(UIButton *)sender {
    
    [AlertViewManager showAlertViewMessage:@"确定要退出登录吗" handlerBlock:^{
        self.apiLoginOut = [[ApiLoginOutRequest alloc]initWithDelegate:self];
        [self.apiLoginOut setApiParams];
        [APIClient execute:self.apiLoginOut];
        [HUDManager showLoadingHUDView:self.view];
        
    }];
}


#pragma mark - private methods

@end
