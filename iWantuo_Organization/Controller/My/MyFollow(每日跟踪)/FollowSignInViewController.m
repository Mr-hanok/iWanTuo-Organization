//
//  FollowSignInViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FollowSignInViewController.h"
#import "ApiFollowAddRequest.h"
#import "CameraTakeMamanger.h"
#import "UploadApiRequest.h"
#import "UploadManager.h"
#import <UIButton+WebCache.h>
#import "ApiFollowChangeRequest.h"


@interface FollowSignInViewController ()<APIRequestDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *remarkTV;//备注
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;//上传图片按钮

@property (weak, nonatomic) IBOutlet UIButton *signBtn;//签到按钮
@property (weak, nonatomic) IBOutlet UIButton *lossBtn;//缺勤按钮

@property (nonatomic, copy) NSString *imageName;//图片名称
@property (nonatomic, strong) ApiFollowAddRequest *apiFollowAdd;//签到
@property (nonatomic, strong) ApiFollowChangeRequest *apiChange;//修改签到
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *loginAccount;

@property (weak, nonatomic) IBOutlet UILabel *followTimeLabel;//追踪时间
@property (weak, nonatomic) IBOutlet UILabel *followTeacherLabel;//追踪老师

@end

@implementation FollowSignInViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //判断是老师还是机构
    if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {//老师
        self.loginName = [AccountManager sharedInstance].account.name;
        self.loginAccount = [AccountManager sharedInstance].account.organizationAccounts;
        
    }else {//机构
        self.loginName = [AccountManager sharedInstance].account.organization;
        self.loginAccount = [AccountManager sharedInstance].account.loginAccounts;
    }

    
    self.remarkTV.layer.borderWidth = 1.f;
    self.remarkTV.layer.borderColor = kBGColor.CGColor;
    self.remarkTV.layer.cornerRadius = 5.f;
    [self.upLoadBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.signBtn.selected = YES;
    self.statusName = @"签到";
    self.apiFollowAdd = [[ApiFollowAddRequest alloc]initWithDelegate:self];
    //注册 刷新页面 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewInfoNotification:) name:ChangeViewInfoNoti object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"每日追踪签到"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"每日追踪签到"];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
    NSDictionary *dic =  [sr.dic objectForKey:@"trace"];
    self.followmodel = [FollowModel initWithDic:dic];
    
    if (api == self.apiFollowAdd) {//追踪签到按钮 新增签到
        [HUDManager showWarningWithText:@"签到成功"];
    }
    if (api == self.apiChange) {//追踪签到修改
        [HUDManager showWarningWithText:@"修改成功"];
    }
    self.imageName = @"";
    //发送通知 修改界面
    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeViewInfoNoti object:self.followmodel];
    //发送通知 修改进度条
    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeImageIvNoti object:self.status];
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {
    
    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}
#pragma mark -  uitextView
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
}

#pragma mark - event respons
/**
 *  签到缺勤按钮
*/
- (IBAction)singOroutBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender == self.signBtn) {
        self.lossBtn.selected = NO;
        self.status = @"1";
        self.statusName = @"签到";
    }
    if (sender == self.lossBtn) {
        self.signBtn.selected = NO;
        self.status = @"4";
        self.statusName = @"缺勤";
    }
}
/**
 *  上传图片按钮
 */
- (IBAction)upLoadBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    // 上传图片
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        
        [HUDManager showLoadingHUDView:self.view];
        [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *fileUrl, NSString *serverUrl, NSString *message) {
            [HUDManager hideHUDView];
            if (fileUrl == nil || [fileUrl isKindOfClass:[NSNull class]]) {
                [AlertViewManager showAlertViewWithMessage:@"服务器异常,请稍后重试"];
                return ;
            }
            
            // 记录图片地址  设置图片
            self.imageName = message;
            [self.upLoadBtn setImage:image forState:UIControlStateNormal];
            
        } failure:^(NSString *message) {
            [HUDManager showWarningWithText:message];
            [HUDManager hideHUDView];
        }];
    } cancelHandler:^{
        
    }];

}
/**
 * 签到按钮
 */
- (IBAction)signBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self.remarkTV.text containsString:[NSString specialBlankCharacter]]) {
        [HUDManager showWarningWithText:@"暂不支持系统表情哦~"
         ];
        return ;
    }
    [HUDManager showLoadingHUDView:KeyWindow];
//    if (![self limitAccountType]) {
//        return;
//    }
    
    if (self.followmodel == nil) {//增加签到
        [self.apiFollowAdd setApiParamsWithCreateDate:self.createDate
                                            studentId:self.studentId
                                 organizationAccounts:self.loginAccount
                                               signIn:self.remarkTV.text
                                          signInImage:self.imageName
                                               status:self.status
                                           statusName:self.statusName signInPerson:self.loginName
                                              classId:self.classId
                                              loginin:[AccountManager sharedInstance].account.loginAccounts];
        
        [APIClient execute:self.apiFollowAdd];

    }
    if (self.followmodel != nil) {//修改签到
        if ([self.followmodel.status isEqualToString:@"2"]) {
            self.status = @"2";
            self.statusName =@"总结";
        }
        if ([self.followmodel.status isEqualToString:@"3"]) {
            self.status = @"3";
            self.statusName =@"离校";
        }

        self.apiChange = [[ApiFollowChangeRequest alloc]initWithDelegate:self];
        [self.apiChange setApiParamsWithId:self.followmodel.kid
                                     leave:@""
                                leaveImage:@""
                                workStatus:@""
                            workStatusName:@""
                                  behavior:@""
                                     study:@""
                                     grade:@""
                                   subject:@""
                               subjectName:@""
                                    status:@""
                                statusName:@""
                                    signIn:self.remarkTV.text
                               signInImage:self.imageName
                                      note:@""
                             summaryPerson:self.loginName
                               leavePerson:self.loginName
                                   loginin:[AccountManager sharedInstance].account.loginAccounts
                                 studentId:self.studentId];

        [APIClient execute:self.apiChange];
    }
}
#pragma mark - private methods

/**
 *  判断是否有权限操作
 */
- (BOOL)limitAccountType{
    if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {//老师renturn NO
        [HUDManager showWarningWithText:@"您没有权限操作！"];
        return NO;
        
    }else {
        return YES;
    }
}
/**
 *  通知方法
 *
 *  @param noti 通知体 包涵追踪model
 */
- (void)changeViewInfoNotification:(NSNotification *)noti{
    FollowModel *info = noti.object;
    self.followmodel = info;
    [self initstallViewWithFollowModel:info];
    if (info != nil) {
        self.remarkTV.text = info.signIn;
        if (![info.status isEqualToString:@"4"]) {
            self.signBtn.selected = YES;
            self.lossBtn.selected = NO;
        }
        if ([info.status isEqualToString:@"4"]) {
            self.lossBtn.selected = YES;
            self.signBtn.selected = NO;
        }
        NSString *str = nil;
        if ([info.signInImage hasPrefix:@"http://www"]) {
            str = info.signInImage;
        }else{
            str = [NSString stringWithFormat:@"%@%@",@"http://www.",info.signInImage];
        }
        NSURL *url = [NSURL URLWithString:str];
        [self.upLoadBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"register_addImageBtn"]];
        //追踪时间老师
        if (![self.followmodel.signinDate isEqualToString:@""]) {
            self.followTimeLabel.text = self.followmodel.signinDate;
        }
        if (![self.followmodel.signinPerson isEqualToString:@""]) {
            self.followTeacherLabel.text = self.followmodel.signinPerson;
        }
    }
    
}
- (void)initstallViewWithFollowModel:(FollowModel *)followModel{
    if (followModel == nil) {
        self.remarkTV.text = @"";
        self.signBtn.selected = YES;
        self.status = @"1";
        self.statusName = @"签到";
        self.lossBtn.selected = NO;
        [self.upLoadBtn sd_setImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"register_addImageBtn"]];
        self.followTimeLabel.text = self.followTeacherLabel.text = @"未签到";
    }
   
}
@end
