//
//  FollowBaseViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FollowBaseViewController.h"
#import "FollowSignInViewController.h"
#import "FollowLeaveViewController.h"
#import "FollowSummaryController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ZHPickView.h"
#import "ApiFollowCheckRequest.h"
#import "FollowModel.h"

@interface FollowBaseViewController ()<UIScrollViewDelegate,ZHPickViewDelegate,APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@property (weak, nonatomic) IBOutlet UIButton *sumaryBtn;
@property (weak, nonatomic) IBOutlet UIButton *leaveBtn;

@property (weak, nonatomic) IBOutlet UIButton *timeBtn;//时间按钮
@property (weak, nonatomic) IBOutlet UIImageView *followIV;//追踪进度图片

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollview;
@property (nonatomic, strong) FollowSignInViewController *signVC;//签到
@property (nonatomic, strong) FollowSummaryController *summaryVC;//总结
@property (nonatomic, strong) FollowLeaveViewController *leaveVC;//离校

@property (nonatomic, copy) NSString *createDate;//记录时间
@property (nonatomic, copy) NSString *status;//状态0删除1签到2总结3离校
@property (nonatomic, copy) NSString *statusName;//状态0删除1签到2总结3离校

@property (nonatomic, strong) ZHPickView *dataPickView;//日期选择器
@property (nonatomic, strong) ApiFollowCheckRequest *apiFollowCheck;//查询
@property (nonatomic, copy) NSString *loginAccounts;
@property (nonatomic, strong) FollowModel *followmodel;

@end

@implementation FollowBaseViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"每日追踪";
    
//    NSDate *  senddate=[NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *str  = [dateformatter stringFromDate:senddate];
//    [self.timeBtn setTitle:str forState:UIControlStateNormal];
//    self.createDate =[NSString stringWithFormat:@"%.0f", senddate.timeIntervalSince1970 ];
    
    self.signBtn.selected = YES;
    self.signVC.createDate = self.createDate;
    self.signVC.status = @"1";
    self.signVC.statusName = @"签到";
    self.signVC.studentId = self.student.studentId;
    
    self.followIV.image = [UIImage imageNamed:@"followshortofline"];
    [self.scrollview addSubview:self.signVC.view];
    [self.scrollview addSubview:self.summaryVC.view];
    [self.scrollview addSubview:self.leaveVC.view];
    
    //判断是老师还是机构
    if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {
        self.loginAccounts = [AccountManager sharedInstance].account.organizationAccounts;
        
    }else {
        self.loginAccounts = [AccountManager sharedInstance].account.loginAccounts;
    }
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImageIvNotification:) name:ChangeImageIvNoti object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.signVC.view setFrame:CGRectMake(0, 0, kScreenBoundWidth, self.scrollview.frame.size.height)];
    
    [self.summaryVC.view setFrame:CGRectMake(kScreenBoundWidth, 0, kScreenBoundWidth, self.scrollview.frame.size.height)];
    
    [self.leaveVC.view setFrame:CGRectMake(kScreenBoundWidth*2, 0, kScreenBoundWidth, self.scrollview.frame.size.height)];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    if (api == self.apiFollowCheck) {//追踪查询 按钮
      NSDictionary *dic =  [sr.dic objectForKey:@"trace"];
        self.followmodel = [FollowModel initWithDic:dic];
        //根据状态设置进度条
        if (self.followmodel != nil) {
            if ([self.followmodel.status isEqualToString:@"1"]) {//签到
                self.followIV.image = [UIImage imageNamed:@"followsignline"];
            }
            if ([self.followmodel.status isEqualToString:@"2"]) {//总结
                self.followIV.image = [UIImage imageNamed:@"followsumupline"];
            }
            if ([self.followmodel.status isEqualToString:@"3"]) {//离校
                self.followIV.image = [UIImage imageNamed:@"followleaveline"];
            }
            //发送通知 刷新界面
            [[NSNotificationCenter defaultCenter] postNotificationName:ChangeViewInfoNoti object:self.followmodel];
        }
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


#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString level1:(NSString *)level1 row1:(NSInteger)row1 row2:(NSInteger)row2{
    NSLog(@"%@",resultString);
    
    //nsstring->nsdate->设置按钮显示时间 记录时间
    NSString *dateStr = [resultString substringToIndex:10];
    NSLog(@"%@",dateStr);
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    outputFormatter.dateFormat       = @"yyyy-MM-dd";
    NSDate *date = [outputFormatter dateFromString:dateStr];
    NSString *str                    = [outputFormatter stringFromDate:date];
    [self.timeBtn setTitle:str forState:UIControlStateNormal];
    self.createDate = [NSString stringWithFormat:@"%.0f", date.timeIntervalSince1970];
    self.signVC.createDate = self.createDate;
    
    
    //执行追踪查询操作
    [HUDManager showLoadingHUDView:self.view];
    self.apiFollowCheck = [[ApiFollowCheckRequest alloc]initWithDelegate:self];
    [self.apiFollowCheck setApiParamsWithCreateDate:self.createDate studentId:self.student.studentId organizationAccounts:self.loginAccounts];
    [APIClient execute:self.apiFollowCheck];
    


}


#pragma mark - event response
/**
 *  签到 总结 追踪按钮
 */
- (IBAction)followBtnsAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender) {
        
    }
    switch (sender.tag) {
        case 101://签到
        {
            self.sumaryBtn.selected = NO;
            self.leaveBtn.selected = NO;
            self.followIV.image = [UIImage imageNamed:@"followshortofline"];
            self.signVC.createDate = self.createDate;
            self.signVC.status = @"1";
            self.signVC.statusName = @"签到";
            self.signVC.studentId = self.student.studentId;
        }
            break;
            
        case 102://总结
        {
            self.signBtn.selected = NO;
            self.leaveBtn.selected = NO;
            self.followIV.image = [UIImage imageNamed:@"followsignline"];
            self.summaryVC.createDate = self.createDate;
            self.summaryVC.status = @"2";
            self.summaryVC.statusName = @"总结";
            self.summaryVC.studentId=self.student.studentId ;

        }
            break;
            
        case 103://离校
        {
            self.sumaryBtn.selected = NO;
            self.signBtn.selected = NO;
            self.followIV.image = [UIImage imageNamed:@"followsumupline"];
            self.leaveVC.createDate = self.createDate;
            self.leaveVC.status = @"3";
            self.leaveVC.statusName = @"离校";
            self.leaveVC.studentId = self.student.studentId;
        }
            break;
    
    }
    /*设置进度条*/
    if (self.followmodel == nil) {
        self.followIV.image = [UIImage imageNamed:@"followshortofline"];
    }else {
        if ([self.followmodel.status isEqualToString:@"1"]) {//签到
            self.followIV.image = [UIImage imageNamed:@"followsignline"];
        }
        if ([self.followmodel.status isEqualToString:@"2"]) {//总结
            self.followIV.image = [UIImage imageNamed:@"followsumupline"];
        }
        if ([self.followmodel.status isEqualToString:@"3"]) {//离校
            self.followIV.image = [UIImage imageNamed:@"followleaveline"];
        }

    }
    //设置scrollview 偏移
    NSInteger a = sender.tag -101;
    [self.scrollview setContentOffset:CGPointMake(a*kScreenBoundWidth, 0) animated:YES];
    
}
/**
 *  时间按钮
 */
- (IBAction)followTimeBtnAction:(UIButton *)sender {
    [_dataPickView remove];
    NSDate *date=[NSDate date];
    _dataPickView=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    _dataPickView.delegate=self;
    [_dataPickView show];
    
    
}
#pragma mark - private methods
/**
 *  通知执行方法 修改进度条图片
 *
 *  @param noti 通知体
 */
- (void)changeImageIvNotification:(NSNotification *)noti{
    NSString *str = noti.object;
    if ([str isEqualToString:@"1"]) {//签到
        self.followIV.image = [UIImage imageNamed:@"followsignline"];
    }
    if ([str isEqualToString:@"2"]) {//总结
        self.followIV.image = [UIImage imageNamed:@"followsumupline"];
    }
    if ([str isEqualToString:@"3"]) {//离校
        self.followIV.image = [UIImage imageNamed:@"followleaveline"];
    }
}
#pragma mark - getters & setters
-(FollowSignInViewController *)signVC{
    if (_signVC == nil) {
        _signVC = [[FollowSignInViewController alloc]init];
    }
    return _signVC;
}
-(FollowSummaryController *)summaryVC{
    if (_summaryVC == nil) {
        _summaryVC = [[FollowSummaryController alloc]init];
    }
    return _summaryVC;
}
-(FollowLeaveViewController *)leaveVC{
    if (_leaveVC == nil) {
        _leaveVC = [[FollowLeaveViewController alloc]init];
    }
    return _leaveVC;
}


@end
