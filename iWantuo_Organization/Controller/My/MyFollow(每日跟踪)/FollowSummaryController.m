//
//  FollowSummaryController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FollowSummaryController.h"
#import "ZHPickView.h"
#import "ApiFollowSubject.h"
#import "ApiFollowChangeRequest.h"
#import "CityInfoModel.h"
#import "ApiFollowChangeRequest.h"

@interface FollowSummaryController ()<ZHPickViewDelegate,APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;//备注
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *xingweiStarts;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *studyStarts;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;//完成作业
@property (weak, nonatomic) IBOutlet UIButton *uncompleteBtn;//未完成作业
@property (weak, nonatomic) IBOutlet UIButton *classChoseBtn;//学科选择btn
@property (weak, nonatomic) IBOutlet UITextField *gradeTF;//成绩

@property (nonatomic, strong) ZHPickView *classPick;//学科选择
@property (nonatomic, strong) ApiFollowSubject *apiSubject;//学科查询
@property (nonatomic, strong) NSMutableArray *subjectArray;//学科数组
@property (nonatomic, strong) NSMutableArray *subjectModelArray;//学科模型数组
@property (nonatomic, strong) ApiFollowChangeRequest *apiChange;//修改追踪
@property (nonatomic, strong) CityInfoModel *model;//记录选中模型

@property (nonatomic, copy) NSString *behavior;//行为评价
@property (nonatomic, copy) NSString *study;//学习评价
@property (nonatomic, copy) NSString *workStatus;//作业状态0未完成1完成
@property (nonatomic, copy) NSString *workStatusName;//作业状态

@end

@implementation FollowSummaryController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.remarkTV.layer.borderWidth = 1.f;
    self.remarkTV.layer.borderColor = kBGColor.CGColor;
    self.remarkTV.layer.cornerRadius = 5.f;
    self.subjectArray = [NSMutableArray array];
    self.subjectModelArray = [NSMutableArray array];
    
    
    self.apiChange = [[ApiFollowChangeRequest alloc]initWithDelegate:self];
    self.apiSubject = [[ApiFollowSubject alloc]initWithDelegate:self];
    [self.apiSubject setApiParams];
    [APIClient execute:self.apiSubject];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewInfoNotification:) name:ChangeViewInfoNoti object:nil];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"跟踪总结页面"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"跟踪总结页面"];
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
    if (api ==self.apiSubject) {//课程
        NSArray *array = [sr.dic objectForKey:@"sysCodeList"];
        for (NSDictionary *dic in array) {
            CityInfoModel *model = [CityInfoModel initWithDic:dic];
            [self.subjectArray addObject:model.name];
            [self.subjectModelArray addObject:model];
        }

    }
    
    if (api == self.apiChange) {//总结
        NSDictionary *dic =  [sr.dic objectForKey:@"trace"];
        self.followmodel = [FollowModel initWithDic:dic];
        //发送通知 传入界面
        [[NSNotificationCenter defaultCenter] postNotificationName:ChangeViewInfoNoti object:self.followmodel];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ChangeImageIvNoti object:@"2"];
        [HUDManager showWarningWithText:@"总结成功"];
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
    NSLog(@"%@-%@-%d-%d",resultString,level1,row1,row2);
    [self.classChoseBtn setTitle:resultString forState:UIControlStateNormal];
    self.model = self.subjectModelArray[row1];
    
}

#pragma mark - event response
/**
 * 是否完成作业按钮
 */
- (IBAction)selectHomeWorkBtns:(UIButton *)sender {
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case 111://已完成作业
            self.uncompleteBtn.selected = NO;
            self.workStatus = @"1";
            self.workStatusName =@"已完成作业";
            break;
            
        case 112://未完成作业
            self.completeBtn.selected = NO;
            self.workStatus = @"0";
            self.workStatusName =@"未完成作业";
            break;
            

    }
}
/**
 * 行为评价
 */
- (IBAction)xingweiCommentAction:(UIButton *)sender {
    
        for (UIButton *btn in self.xingweiStarts) {
        [btn setImage:[UIImage imageNamed:@"organization_StarYellow"] forState:UIControlStateNormal];
        if (btn.tag > sender.tag) {
            [btn setImage:[UIImage imageNamed:@"organization_StarGray"] forState:UIControlStateNormal];
        }
        if (sender.tag == btn.tag) {
            self.behavior = [NSString stringWithFormat:@"%d",btn.tag-100];
        }
    }

}
/**
 * 学习评价
 */
- (IBAction)studyCommentAction:(UIButton *)sender {

    for (UIButton *btn in self.studyStarts) {
        [btn setImage:[UIImage imageNamed:@"organization_StarYellow"] forState:UIControlStateNormal];
        if (btn.tag > sender.tag) {
            [btn setImage:[UIImage imageNamed:@"organization_StarGray"] forState:UIControlStateNormal];
        }
        if (sender.tag == btn.tag) {
            self.study = [NSString stringWithFormat:@"%d",btn.tag-105];
        }
    }

}
/**
 * 学科选择
 */
- (IBAction)classChoseAction:(UIButton *)sender {
    [_classPick remove];
    _classPick=[[ZHPickView alloc] initPickviewWithArray:self.subjectArray isHaveNavControler:NO];
    _classPick.delegate=self;
    [_classPick show];

}
/**
 * 总结按钮
 */
- (IBAction)sumupAction:(UIButton *)sender {
    [HUDManager showLoadingHUDView:KeyWindow];
    
    [self.apiChange setApiParamsWithId:self.followmodel.kid
                                 leave:@""
                            leaveImage:@""
                            workStatus:self.workStatus
                        workStatusName:self.workStatusName
                              behavior:self.behavior
                                 study:self.study
                                 grade:self.gradeTF.text
                               subject:self.model.cityId
                           subjectName:self.model.name
                                status:@"2"
                            statusName:@"总结"];
    [APIClient execute:self.apiChange];

}
#pragma mark - private methods
- (void)changeViewInfoNotification:(NSNotification *)noti{
    FollowModel *info = noti.object;
    self.followmodel = info;
    self.remarkTV.text = info.leave;
    if ([self.followmodel.workStatus isEqualToString:@"1"]) {
        self.completeBtn.selected = YES;
        self.uncompleteBtn.selected = NO;
    }
    [self.classChoseBtn setTitle:self.followmodel.subjectName forState:UIControlStateNormal];
    self.gradeTF.text = self.followmodel.grade;
    //设置星星显示
    NSInteger num1 = [self.followmodel.behavior integerValue]+100;
    for (UIButton *btn in self.xingweiStarts) {
        [btn setImage:[UIImage imageNamed:@"organization_StarYellow"] forState:UIControlStateNormal];
        if (btn.tag > num1) {
            [btn setImage:[UIImage imageNamed:@"organization_StarGray"] forState:UIControlStateNormal];
        }
        if (num1 == btn.tag) {
            self.study = [NSString stringWithFormat:@"%d",btn.tag-100];
        }
    }
    NSInteger num2 = [self.followmodel.study integerValue]+105;
    for (UIButton *btn in self.studyStarts) {
        [btn setImage:[UIImage imageNamed:@"organization_StarYellow"] forState:UIControlStateNormal];
        if (btn.tag > num2) {
            [btn setImage:[UIImage imageNamed:@"organization_StarGray"] forState:UIControlStateNormal];
        }
        if (num2 == btn.tag) {
            self.study = [NSString stringWithFormat:@"%d",btn.tag-105];
        }
    }


}
@end
