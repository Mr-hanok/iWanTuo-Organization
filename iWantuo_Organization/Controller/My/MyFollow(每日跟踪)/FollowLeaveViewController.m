//
//  FollowLeaveViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FollowLeaveViewController.h"
#import "ApiFollowChangeRequest.h"
#import "UploadManager.h"
#import "CameraTakeMamanger.h"
#import <UIButton+WebCache.h>

@interface FollowLeaveViewController ()<APIRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextView *remarkTV;//备注
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;//上传图片按钮
@property (nonatomic, copy) NSString *imageName;//记录图片名
@property (nonatomic, copy) NSString *loginName;

@property (weak, nonatomic) IBOutlet UILabel *followTimeLabel;//追踪时间
@property (weak, nonatomic) IBOutlet UILabel *followTeacherLabel;//追踪老师

@property (nonatomic, strong) ApiFollowChangeRequest *apiChange;//改变跟踪状态接口
@end

@implementation FollowLeaveViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断是老师还是机构
    if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {//老师
        self.loginName = [AccountManager sharedInstance].account.name;
        
    }else {//机构
        self.loginName = [AccountManager sharedInstance].account.organization;
    }
    


    self.remarkTV.layer.borderWidth = 1.f;
    self.remarkTV.layer.borderColor = kBGColor.CGColor;
    self.remarkTV.layer.cornerRadius = 5.f;
    [self.upLoadBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    self.apiChange = [[ApiFollowChangeRequest alloc]initWithDelegate:self];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewInfoNotification:) name:ChangeViewInfoNoti object:nil];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"每日追踪离校"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"每日追踪离校"];
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
    self.imageName = @"";
    //发送通知 改变进度条图片
    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeImageIvNoti object:@"3"];
    [HUDManager showWarningWithText:@"成功"];
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
 * 离校按钮
 */
- (IBAction)signBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (self.followmodel ==nil) {
        [HUDManager showWarningWithText:@"请先签到"];
        return;
    }
    [HUDManager showLoadingHUDView:KeyWindow];
    [self.apiChange setApiParamsWithId:self.followmodel.kid
                                 leave:self.remarkTV.text
                            leaveImage:self.imageName
                            workStatus:@""
                        workStatusName:@""
                              behavior:@""
                                 study:@""
                                 grade:@""
                               subject:@""
                           subjectName:@""
                                status:@"3"
                            statusName:@"离校"
                                signIn:@""
                           signInImage:@""
                                  note:@""
                         summaryPerson:@""
                           leavePerson:self.loginName
                               loginin:[AccountManager sharedInstance].account.loginAccounts];
    [APIClient execute:self.apiChange];
}
#pragma mark - private methods
- (void)changeViewInfoNotification:(NSNotification *)noti{
    FollowModel *info = noti.object;
    self.followmodel = info;
    if (info != nil) {
        self.remarkTV.text = info.leave;
        //设置图片
        NSString *str = nil;
        if ([info.leaveImage hasPrefix:@"http://www"]) {
            str = info.leaveImage;
        }else{
            str = [NSString stringWithFormat:@"%@%@",@"http://www.",info.leaveImage];
        }
        NSURL *url = [NSURL URLWithString:str];
        [self.upLoadBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"register_addImageBtn"]];
        //追踪时间老师
        if (![self.followmodel.leaveDate isEqualToString:@""]) {
            self.followTimeLabel.text = self.followmodel.leaveDate;
        }
        if (![self.followmodel.leavePerson isEqualToString:@""]) {
            self.followTeacherLabel.text = self.followmodel.leavePerson;
        }

    }else{
        self.remarkTV.text = @"";
        [self.upLoadBtn sd_setImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"register_addImageBtn"]];
        self.followTimeLabel.text = self.followTeacherLabel.text = @"未离校";
    }
    
    
    
}


@end
