//
//  LoginViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/14.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "LoginViewController.h"
#import "SystemHandler.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "ApiLoginRequest.h"

typedef enum :NSInteger {
    AccountParent=1,//家长 机构 老师
    AccountOrganizaton,
    AccountTeacher
}AccoutnLoginType;

@interface LoginViewController ()<UITextFieldDelegate,APIRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;//用户名
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;//密码
@property (nonatomic, strong) ApiLoginRequest *apiLogin;//登录接口

@property (nonatomic, assign) AccoutnLoginType type;
@end

@implementation LoginViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.apiLogin = [[ApiLoginRequest alloc]initWithDelegate:self];
    self.userNameTF.text = [AccountManager sharedInstance].account.loginAccounts;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (string.length == 0) return YES;
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    //大于11位 不能在输入
    if (existedLength - selectedLength + replaceLength > 11) {
        return NO;
    }
    
    return YES;
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
    NSDictionary *teacherDic = [sr.dic objectForKey:[ValueUtils stringFromObject:@"Teacher"]];
    NSDictionary *origanDic = [sr.dic objectForKey:[ValueUtils stringFromObject:@"Organization"]];
    AccountModel *model = nil;
    if ([teacherDic isKindOfClass:[NSNull class]] && origanDic ==nil ) {
        [HUDManager showWarningWithText:@"尚未认证！"];
        return;
    }
    if ([origanDic isKindOfClass:[NSNull class]] && teacherDic == nil ) {
        [HUDManager showWarningWithText:@"尚未认证！"];
        return;
    }
    if (teacherDic) {//教师登录
        self.type = AccountTeacher;
        model =[AccountModel initWithDict:[sr.dic objectForKey:@"Teacher"] accountType:@"3"];
    }
    
    if (origanDic) {//机构登录
        self.type = AccountOrganizaton;
        model =[AccountModel initWithDict:[sr.dic objectForKey:@"Organization"] accountType:@"2"];
    }
    //保存用户信息
    model.isLogin = @"yes";
    [AccountManager sharedInstance].account = model;
    [[AccountManager sharedInstance] saveAccountInfoToDisk];
    //登录成功 切换根控制器
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

#pragma mark - event response
/**
 *  登录
 */
- (IBAction)loginAction {
    [self.view endEditing:YES];
    //数据校验
    if([self dataCheck]){
        [HUDManager showLoadingHUDView:self.view];
        [self.apiLogin setApiParamsWithLoginAccount:self.userNameTF.text Password:self.passWordTF.text];
        [APIClient execute:self.apiLogin];
    }
    //登录成功 切换根控制器
   // KeyWindow.rootViewController= [SystemHandler rootViewController];
    
}
/**
 *  忘记密码
 */
- (IBAction)forgetPasswordAction:(UIButton *)sender {
    
    ForgetViewController *vc = [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  注册
 */
- (IBAction)registerAction:(UIButton *)sender {
    
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - private methods

- (BOOL)dataCheck{
    if (self.userNameTF.text.length==0 || [[self.userNameTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入账号"];
        return NO;
    }
    if (self.passWordTF.text.length==0 || [[self.passWordTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入密码"];
        return NO;
    }
    if (![NSString tf_isSimpleMobileNumber:self.userNameTF.text]  ) {
        [HUDManager showWarningWithText:@"请输入正确手机号"];
        return NO;
    }
    if ([self.passWordTF.text containsString:[NSString specialBlankCharacter]]) {
        [HUDManager showWarningWithText:@"暂不支持系统表情哦~"
         ];
        return NO;
    }
    return YES;
}
@end
