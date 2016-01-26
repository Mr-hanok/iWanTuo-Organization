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



@interface FollowSignInViewController ()<APIRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextView *remarkTV;//备注
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;//上传图片按钮

@property (weak, nonatomic) IBOutlet UIButton *signBtn;//签到按钮
@property (weak, nonatomic) IBOutlet UIButton *lossBtn;//缺勤按钮

@property (nonatomic, copy) NSString *imageName;//图片名称
@property (nonatomic, strong) ApiFollowAddRequest *apiFollowAdd;//签到

@end

@implementation FollowSignInViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.remarkTV.layer.borderWidth = 1.f;
    self.remarkTV.layer.borderColor = kBGColor.CGColor;
    self.remarkTV.layer.cornerRadius = 5.f;
    self.signBtn.selected = YES;
    self.apiFollowAdd = [[ApiFollowAddRequest alloc]initWithDelegate:self];
    
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
    if (api == self.apiFollowAdd) {//追踪查询 按钮
        NSDictionary *dic =  [sr.dic objectForKey:@"trace"];
        self.followmodel = [FollowModel initWithDic:dic];

        //发送通知 传入界面
        [[NSNotificationCenter defaultCenter] postNotificationName:ChangeViewInfoNoti object:self.followmodel];
    }

   [[NSNotificationCenter defaultCenter] postNotificationName:ChangeImageIvNoti object:@"1"];
    [HUDManager showWarningWithText:@"签到成功"];
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {
    
    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}


#pragma mark - event respons
/**
 *  签到缺勤按钮
*/
- (IBAction)singOroutBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender == self.signBtn) {
        self.lossBtn.selected = NO;
    }
    if (sender == self.lossBtn) {
        self.signBtn.selected = NO;
    }
}
/**
 *  上传图片按钮
 */
- (IBAction)upLoadBtnAction:(UIButton *)sender {
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
    [HUDManager showLoadingHUDView:KeyWindow];
    if (![self limitAccountType]) {
        return;
    }
    
    [self.apiFollowAdd setApiParamsWithCreateDate:self.createDate
                                        studentId:self.studentId
                             organizationAccounts:[AccountManager sharedInstance].account.loginAccounts
                                           signIn:self.remarkTV.text
                                      signInImage:self.imageName
                                           status:self.status
                                       statusName:self.statusName];
    [APIClient execute:self.apiFollowAdd];
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
- (void)changeViewInfoNotification:(NSNotification *)noti{
    FollowModel *info = noti.object;
    self.remarkTV.text = info.signIn;
    NSString *str = [NSString stringWithFormat:@"%@%@",@"http://www.",info.signInImage];
    NSURL *url = [NSURL URLWithString:str];
    NSLog(@"%@",url);
    [self.upLoadBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"register_addImageBtn"]];

}
@end
