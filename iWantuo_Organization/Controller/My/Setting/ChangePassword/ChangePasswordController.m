//
//  ChangePasswordController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ChangePasswordController.h"
#import "ChangePasswordRequest.h"
#import "LoginViewController.h"
#import "SystemHandler.h"

@interface ChangePasswordController ()<APIRequestDelegate>

//旧密码
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
//新密码
@property (weak, nonatomic) IBOutlet UITextField *changePasswordTF;
//确认密码
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTF;


@property(nonatomic,strong)ChangePasswordRequest *changePasswordAPi;//修改密码请求

@end

@implementation ChangePasswordController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    
    self.changePasswordAPi = [[ChangePasswordRequest alloc]initWithDelegate:self];
}




#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error
{
    [HUDManager hideHUDView];
    [HUDManager showWarningWithText:kDefaultNetWorkErrorString];
}
- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr
{
    [HUDManager hideHUDView];
    
    [HUDManager showWarningWithText:@"修改成功,请重新登录"];
    //保存用户信息
    AccountModel *model =[AccountManager sharedInstance].account;
    model.isLogin = @"no";
    [[AccountManager sharedInstance] saveAccountInfoToDisk];
    kRootViewController = [SystemHandler rootViewController];
    
}
- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr
{
    [HUDManager hideHUDView];
    [AlertViewManager showAlertViewWithMessage:sr.msg];
    
}

#pragma mark - event response
- (IBAction)sureButtonAction:(UIButton *)sender {
    
    DDLog(@"确定 修改 －－修改成功之后需要重新登录");
    
    if([self judgePassword] == YES){
        NSMutableDictionary *changeDic = [NSMutableDictionary dictionary];
        [changeDic setObject:self.oldPasswordTF.text forKey:@"oldPassword"];
        [changeDic setObject:self.changePasswordTF.text forKey:@"newPassword"];
        [self.changePasswordAPi setApiParmsWithDic:changeDic];
        [APIClient execute:self.changePasswordAPi];
        [HUDManager showLoadingHUDView:self.view withText:@"修改中"];
    }
}



#pragma mark - private methods


- (BOOL)judgePassword
{
    if ([self.oldPasswordTF.text isEqualToString:@""]||self.oldPasswordTF.text == nil) {
        [HUDManager showWarningWithText:@"请输入原密码"];
        return NO;
    }
    if (self.changePasswordTF.text.length == 0) {
        [HUDManager showWarningWithText:@"请输入新密码"];
        return NO;
    }
    if (self.changePasswordTF.text.length<6 || self.changePasswordTF.text.length>30) {
        [HUDManager showWarningWithText:@"请输入6位以上密码"];
        return NO;
    }
    if(![self.verifyPasswordTF.text isEqualToString:self.changePasswordTF.text]){
        [HUDManager showWarningWithText:@"两次密码不一致"];
        return NO;
    }
    return YES;
}


@end
