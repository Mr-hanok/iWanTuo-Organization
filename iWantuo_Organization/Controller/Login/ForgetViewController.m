//
//  ForgetViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ForgetViewController.h"
#import "ApiFindPassWord.h"

@interface ForgetViewController ()<APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic,strong)UIButton *leftBtn;//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;//提交
@property (weak, nonatomic) IBOutlet UITextField *registerNumTF;//验证码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//电话号
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;//密码

@property (nonatomic, strong) ApiFindPassWord *apiFind;//找回密码
@end

@implementation ForgetViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"忘记密码";
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
    //修改成功 重新登陆
    [HUDManager showWarningWithText:@"修改成功!重新登陆"];
    [self.navigationController popViewControllerAnimated:YES];
    
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

- (void)backItemAction{//返回按钮
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  提交按钮
 */
- (IBAction)commitAction:(UIButton *)sender {
    
    self.apiFind = [[ApiFindPassWord alloc]initWithDelegate:self];

    [self.apiFind setApiParamsWithLoginAccount:self.passwordTF.text Password:self.passwordTF.text];
    [APIClient execute:self.apiFind];
}
/**
 *  验证码按钮
 */
- (IBAction)registerAction:(UIButton *)sender {
    
}
#pragma mark - private methods


@end
