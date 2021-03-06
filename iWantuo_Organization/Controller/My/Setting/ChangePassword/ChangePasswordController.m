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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
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
    
    [HUDManager showWarningWithText:@"修改密码成功!"];
    //保存用户信息
    [self.navigationController popToRootViewControllerAnimated:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        kRootViewController = [SystemHandler rootViewController];
//    });
    
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
    
    if ([self.oldPasswordTF.text containsString:[NSString specialBlankCharacter]] || [self.changePasswordTF.text containsString:[NSString specialBlankCharacter]] || [self.verifyPasswordTF.text containsString:[NSString specialBlankCharacter]]) {
        [HUDManager showWarningWithText:@"暂不支持系统表情哦~"
         ];
        return NO;
    }
    
    return YES;
}


@end
