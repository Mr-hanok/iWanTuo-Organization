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

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet JKCountDownButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;//提交
@property (weak, nonatomic) IBOutlet UITextField *registerNumTF;//验证码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//电话号
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;//密码


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

#pragma mark - 协议名

#pragma mark - event response

/**
 *  提交按钮
 */
- (IBAction)commitAction:(UIButton *)sender {
    
    SigningViewController *vc = [[SigningViewController alloc]init];
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
    [sender startWithSecond:5];
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
        [countDownButton setBackgroundColor:[UIColor clearColor]];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"重新获取";
    }];
    
    
}

#pragma mark - private methods

@end
