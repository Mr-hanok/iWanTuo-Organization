//
//  AddClassTeacherViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AddClassTeacherViewController.h"
#import "ApiAddTeacherRequest.h"

@interface AddClassTeacherViewController ()<APIRequestDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//电话
@property (weak, nonatomic) IBOutlet UITextField *nameTF;//名字
@property (weak, nonatomic) IBOutlet UITextField *accountTF;//账号
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;//密码

@property (nonatomic, strong) ApiAddTeacherRequest *api;

@end

@implementation AddClassTeacherViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加辅导员";
    
    self.phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    self.passWordTF.keyboardType = UIKeyboardTypeEmailAddress;
    self.accountTF.delegate = self;
    self.passWordTF.delegate = self;
    
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
#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    [HUDManager hideHUDView];
    
    [AlertViewManager showAlertViewWithMessage:kDefaultNetWorkErrorString];
    
}

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {
    [HUDManager hideHUDView];
    
    if (sr.dic == nil || [sr.dic isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if (sr.status == 0) {
        [HUDManager showWarningWithText:sr.msg];
        [self.navigationController popViewControllerAnimated:YES];
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

#define NUMBERS @"0123456789.abcdefghigklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"//只允许输入字母数字或者点号

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.accountTF || textField == self.passWordTF) {
        NSCharacterSet *cs;
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            [HUDManager showWarningWithText:@"不能输入特殊字符"];
            return NO;
        }
        return YES;
    }
    
    // return NO to not change text
    
    return YES;
}


#pragma mark - event response

- (IBAction)addBtnAction:(UIButton *)sender {
    if ([self dataCheck]) {
        self.api = [[ApiAddTeacherRequest alloc] initWithDelegate:self];
        [self.api setApiParamsWithLoginAccounts:self.accountTF.text password:self.passWordTF.text organizationAccounts:[AccountManager sharedInstance].account.loginAccounts name:self.nameTF.text phone:self.phoneNumTF.text];
        [APIClient execute:self.api];
        [HUDManager showLoadingHUDView:self.view];
    }
}
#pragma mark - private methods
- (BOOL)dataCheck{
    if (self.nameTF.text.length == 0 || [[self.nameTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入名称"];
        return NO;
    }
    if (self.passWordTF.text.length == 0 || [[self.passWordTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入密码"];
        return NO;
    }
    if (self.accountTF.text.length==0 || [[self.accountTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入账号"];
        return NO;
    }
    //判断账号是否是手机号
    if (![NSString tf_isSimpleMobileNumber:self.accountTF.text] || [[self.accountTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入正确手机号"];
        return NO;
    }
    if (![NSString tf_isSimpleMobileNumber:self.phoneNumTF.text] || [[self.phoneNumTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入正确手机号"];
        return NO;
    }
    return YES;
}



@end
