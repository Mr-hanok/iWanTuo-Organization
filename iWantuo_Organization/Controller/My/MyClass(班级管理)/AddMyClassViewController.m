//
//  AddMyClassViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AddMyClassViewController.h"
#import "ApiAddClassRequest.h"

@interface AddMyClassViewController ()<APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextField *classNameTF;
@property (nonatomic, strong) ApiAddClassRequest *api;

@end

@implementation AddMyClassViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加班级";
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

#pragma mark - event response
- (IBAction)addClassBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.classNameTF.text.length == 0 || [[self.classNameTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入班级名称"];
        return;
    }
    
    self.api = [[ApiAddClassRequest alloc] initWithDelegate:self];
    [self.api setApiParamsWithOrganizationAccounts:[AccountManager sharedInstance].account.loginAccounts organizationClass:self.classNameTF.text];
    [APIClient execute:self.api];
    [HUDManager showLoadingHUDView:self.view];
    
}


#pragma mark - private methods



@end
