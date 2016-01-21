//
//  AddClassTeacherViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AddClassTeacherViewController.h"

@interface AddClassTeacherViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//电话
@property (weak, nonatomic) IBOutlet UITextField *nameTF;//名字
@property (weak, nonatomic) IBOutlet UITextField *accountTF;//账号
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;//密码

@end

@implementation AddClassTeacherViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加辅导员";
}
#pragma mark - 协议名
#pragma mark - event response

- (IBAction)addBtnAction:(UIButton *)sender {
}
#pragma mark - private methods
- (BOOL)dataCheck{
    if (self.nameTF.text.length==0) {
        [HUDManager showWarningWithText:@"请输入名称"];
        return NO;
    }
    if (self.passWordTF.text.length==0) {
        [HUDManager showWarningWithText:@"请输入密码"];
        return NO;
    }
    if (self.accountTF.text.length==0) {
        [HUDManager showWarningWithText:@"请输入账号"];
        return NO;
    }
    if (self.phoneNumTF.text.length==0) {
        [HUDManager showWarningWithText:@"请输入手机号"];
        return NO;
    }
    if (![NSString tf_isSimpleMobileNumber:self.phoneNumTF.text]  ) {
        [HUDManager showWarningWithText:@"请输入正确手机号"];
        return NO;
    }
    return YES;
}

@end
