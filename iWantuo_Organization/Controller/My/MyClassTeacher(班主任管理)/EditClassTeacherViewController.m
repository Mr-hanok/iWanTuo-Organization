//
//  EditClassTeacherViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/2/17.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "EditClassTeacherViewController.h"
#import "ApiEditTeacherRequest.h"
#import "TeacherModel.h"

@interface EditClassTeacherViewController ()<APIRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//电话
@property (weak, nonatomic) IBOutlet UITextField *nameTF;//名字
@property (weak, nonatomic) IBOutlet UITextField *accountTF;//账号
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;//密码

@property (nonatomic, strong) ApiEditTeacherRequest *api;
@end

@implementation EditClassTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"辅导老师编辑";
    //初始化界面信息
    self.phoneNumTF.text = self.model.phone;
    self.nameTF.text = self.model.teacherName;
    self.accountTF.text = self.model.loginAccounts;
    self.passWordTF.text = self.model.passWord;
    self.phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
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
#pragma mark - event response
/**
 * 修改按钮
 */
- (IBAction)editBtnAction:(UIButton *)sender {
    if ([self dataCheck]) {
        self.api = [[ApiEditTeacherRequest alloc] initWithDelegate:self];
        [self.api setApiParamsWithTeacherId:self.model.teacherId name:self.nameTF.text phone:self.phoneNumTF.text];
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
    if (![NSString tf_isSimpleMobileNumber:self.phoneNumTF.text] || [[self.phoneNumTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入正确手机号"];
        return NO;
    }
    return YES;
}

@end
