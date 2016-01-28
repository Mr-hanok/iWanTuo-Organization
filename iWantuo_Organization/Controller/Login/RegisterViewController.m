//
//  RegisterViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "RegisterViewController.h"
#import "JKCountDownButton.h"
#import "SigningViewController.h"
#import "ApiSendPhoneMessage.h"


@interface RegisterViewController ()<UITextFieldDelegate,APIRequestDelegate>
@property (weak, nonatomic) IBOutlet JKCountDownButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;//提交
@property (weak, nonatomic) IBOutlet UITextField *registerNumTF;//验证码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//电话号
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;//密码

@property (nonatomic, strong) ApiSendPhoneMessage *apiSM;//短信验证
@property (nonatomic, copy) NSString *verificatCode;//记录短信码
@end

@implementation RegisterViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"机构注册";
    //设置验证码按钮
    [self.registerBtn setTitleColor:kNavigationColor forState:UIControlStateNormal];
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
   self.verificatCode = [ValueUtils stringFromObject:[sr.dic objectForKey:@"verificatCode"]];
    
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
    //校验>>发送验证码请求
    if (![self dataCheck]) {
        return;
    }
    if (![self.verificatCode isEqualToString:self.registerNumTF.text]) {
        [HUDManager showWarningWithText:@"验证码不正确"];
        return;
    }
    SigningViewController *vc = [[SigningViewController alloc]init];
    vc.phoneNum = self.phoneNumTF.text;
    vc.passWord = self.passwordTF.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}
/**
 *  注册码
 */
- (IBAction)registerBtnActon:(JKCountDownButton *)sender {
    //校验>倒计时>发送验证码请求
    if (![NSString tf_isSimpleMobileNumber:self.phoneNumTF.text]) {
        [HUDManager showWarningWithText:@"请输入正确手机号码！"];
        return;
    }
    //倒计时
    sender.enabled = NO;
    [sender startWithSecond:30];
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
        [countDownButton setBackgroundColor:[UIColor clearColor]];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"重新获取";
    }];
    //请求接口
    self.apiSM = [[ApiSendPhoneMessage alloc]initWithDelegate:self];
    [self.apiSM setApiParamsWithPhone:self.phoneNumTF.text];
    [APIClient execute:self.apiSM];
    
    
}

#pragma mark - private methods

- (BOOL)dataCheck{
    if (![NSString tf_isSimpleMobileNumber:self.phoneNumTF.text]) {
        [HUDManager showWarningWithText:@"请输入正确手机号码！"];
        return NO;
    }
    if (self.phoneNumTF.text.length==0) {
        [HUDManager showWarningWithText:@"请输入手机号码！"];
        return NO;
    }
    if (self.registerNumTF.text.length == 0) {
        [HUDManager showWarningWithText:@"请输入验证码"];
        return NO;
    }
    if (self.passwordTF.text.length == 0) {
        [HUDManager showWarningWithText:@"请输入密码"];
        return NO;
    }
    
    if (self.passwordTF.text.length<6 || self.passwordTF.text.length>30) {
        [HUDManager showWarningWithText:@"请输入6位以上密码"];
        return NO;
    }
    return YES;
}
@end
