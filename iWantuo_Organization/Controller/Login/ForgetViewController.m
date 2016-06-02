//
//  ForgetViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ForgetViewController.h"
#import "ApiFindPassWord.h"
#import "ApiSendPhoneMessage.h"
#import "JKCountDownButton.h"
#import "ApiLoginRequest.h"
#import "SystemHandler.h"

@interface ForgetViewController ()<APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic,strong)UIButton *leftBtn;//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;//提交
@property (weak, nonatomic) IBOutlet UITextField *registerNumTF;//验证码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//电话号
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;//密码

@property (nonatomic, strong) ApiFindPassWord *apiFind;//找回密码
@property (nonatomic, strong) ApiSendPhoneMessage *apiSM;//短信
@property (nonatomic, copy) NSString *verificatCode;
@property (nonatomic, strong) ApiLoginRequest *apiLogin;//登录接口
@end

@implementation ForgetViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"忘记密码";
    //设置验证码按钮
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundColor:kNavigationColor];
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
    if (api == self.apiFind) {//找回密码
        //修改成功 调用登录接口 直接登录
//        [HUDManager showWarningWithText:@"找回成功，请登录"];
//        [self.navigationController popViewControllerAnimated:YES];
        [HUDManager showLoadingHUDView:self.view];
        self.apiLogin = [[ApiLoginRequest alloc]initWithDelegate:self];
        [self.apiLogin setApiParamsWithLoginAccount:self.phoneNumTF.text Password:self.passwordTF.text];
        [APIClient execute:self.apiLogin];

    }
    if (api == self.apiLogin) {
        [self loginsuccess:sr];
    }
    if (api == self.apiSM) {//短信验证
        [self countDownBtn:self.registerBtn];
        //记录验证码
        self.verificatCode = [ValueUtils stringFromObject:[sr.dic objectForKey:@"verificatCode"]];
    }
    
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
 *  提交按钮
 */
- (IBAction)commitAction:(UIButton *)sender {
    if (![self dataCheck]) {
        return;
    }
    if (![self.verificatCode isEqualToString:self.registerNumTF.text]) {
        [HUDManager showWarningWithText:@"验证码不正确"];
        return;
    }

    self.apiFind = [[ApiFindPassWord alloc]initWithDelegate:self];

    [self.apiFind setApiParamsWithLoginAccount:self.phoneNumTF.text Password:self.passwordTF.text];
    [APIClient execute:self.apiFind];
}
/**
 *  验证码按钮
 */
- (IBAction)registerAction:(JKCountDownButton *)sender {
    if (![NSString tf_isSimpleMobileNumber:self.phoneNumTF.text]) {
        [HUDManager showWarningWithText:@"请输入正确手机号码！"];
        return;
    }
    
    //获取验证码请求
    self.apiSM = [[ApiSendPhoneMessage alloc]initWithDelegate:self];
    [self.apiSM setApiParamsWithPhone:self.phoneNumTF.text];
    self.apiSM.type = @"1";
    [APIClient execute:self.apiSM];

}

#pragma mark - private methods
- (void)countDownBtn:(JKCountDownButton *)sender{
    //倒计时
    sender.enabled = NO;
    [sender startWithSecond:30];
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
        [countDownButton setBackgroundColor:[UIColor darkGrayColor]];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        [countDownButton setBackgroundColor:kNavigationColor];
        countDownButton.enabled = YES;
        return @"重新获取";
    }];
    
}

- (BOOL)dataCheck{
    if (![NSString tf_isSimpleMobileNumber:self.phoneNumTF.text]) {
        [HUDManager showWarningWithText:@"请输入正确手机号码！"];
        return NO;
    }
    if (self.phoneNumTF.text.length==0 || [[self.phoneNumTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入手机号码！"];
        return NO;
    }
    if (self.registerNumTF.text.length == 0 || [[self.registerNumTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入验证码"];
        return NO;
    }
    if (self.passwordTF.text.length == 0 || [[self.registerNumTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入密码"];
        return NO;
    }
    if ([self.passwordTF.text containsString:[NSString specialBlankCharacter]]) {
        [HUDManager showWarningWithText:@"暂不支持系统表情哦~"
         ];
        return NO;
    }
    
    return YES;
}
- (void)loginsuccess:(APIResult *)sr{
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
        model =[AccountModel initWithDict:[sr.dic objectForKey:@"Teacher"] accountType:@"3"];
    }
    
    if (origanDic) {//机构登录
        model =[AccountModel initWithDict:[sr.dic objectForKey:@"Organization"] accountType:@"2"];
    }
    //保存用户信息
    model.isLogin = @"yes";
    [AccountManager sharedInstance].account = model;
    [[AccountManager sharedInstance] saveAccountInfoToDisk];
    //登录成功 切换根控制器
    kRootViewController = [SystemHandler rootViewController];

}

@end
