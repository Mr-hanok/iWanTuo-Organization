//
//  FollowSummaryController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//
#define ClassViewHeight 30.0
#import "FollowSummaryController.h"
#import "ZHPickView.h"
#import "ApiFollowSubject.h"
#import "ApiFollowChangeRequest.h"
#import "CityInfoModel.h"
#import "ApiFollowChangeRequest.h"

@interface FollowSummaryController ()<ZHPickViewDelegate,APIRequestDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;//备注
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *xingweiStarts;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *studyStarts;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;//完成作业
@property (weak, nonatomic) IBOutlet UIButton *uncompleteBtn;//未完成作业
@property (weak, nonatomic) IBOutlet UIButton *classChoseBtn;//学科选择btn
@property (weak, nonatomic) IBOutlet UITextField *gradeTF;//成绩

@property (nonatomic, strong) ApiFollowSubject *apiSubject;//学科查询
@property (nonatomic, strong) NSMutableArray *subjectArray;//学科数组
@property (nonatomic, strong) NSMutableArray *subjectModelArray;//学科模型数组
@property (nonatomic, strong) ApiFollowChangeRequest *apiChange;//改变跟踪状态接口
@property (nonatomic, strong) CityInfoModel *model;//记录选中模型

@property (nonatomic, copy) NSString *behavior;//行为评价
@property (nonatomic, copy) NSString *study;//学习评价
@property (nonatomic, copy) NSString *workStatus;//作业状态0未完成1完成
@property (nonatomic, copy) NSString *workStatusName;//作业状态
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *summaryPerson;
@property (nonatomic, copy) NSString *leavePerson;

@property (weak, nonatomic) IBOutlet UIView *classView;//学科总view
@property (weak, nonatomic) IBOutlet UIButton *addClassBtn;//添加学科按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightLayout;//学科view高度
@property (nonatomic)NSInteger count;
@property (nonatomic, strong) NSMutableArray *otherBtns;//其他学科btn
@property (nonatomic, strong) NSMutableArray *otherTF;//其他学科TF
@property (nonatomic, strong) NSMutableArray *otherView;//线
@property (nonatomic, copy) NSString *classid;//学科id
@property (nonatomic, copy) NSString *className;//学科name
@property (nonatomic, copy) NSString *classGrade;//学科分数

@property (nonatomic, strong) NSMutableArray *xuekes;//学科数组
@property (nonatomic, strong) NSMutableArray *fenshus;//分数数组
@property (nonatomic)NSInteger few;


@end

@implementation FollowSummaryController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 1;
    //判断是老师还是机构
    if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {//老师
        self.loginName = [AccountManager sharedInstance].account.name;
        
    }else {//机构
        self.loginName = [AccountManager sharedInstance].account.organization;
    }

    self.remarkTV.layer.borderWidth = 1.f;
    self.remarkTV.layer.borderColor = kBGColor.CGColor;
    self.remarkTV.layer.cornerRadius = 5.f;
    self.subjectArray = [NSMutableArray array];
    self.subjectModelArray = [NSMutableArray array];
    self.otherBtns = [NSMutableArray array];
    self.otherTF = [NSMutableArray array];
    self.otherView = [NSMutableArray array];
    self.classid = @"";
    self.className = @"";
    self.classGrade = @"";
    self.xuekes = [NSMutableArray array];
    self.fenshus = [NSMutableArray array];
    
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
        self.gradeTF.text = nil;
        self.model = nil;
        //发送通知 传入界面
        [[NSNotificationCenter defaultCenter] postNotificationName:ChangeViewInfoNoti object:self.followmodel];
        //发送通知 改变进度条图片
        [[NSNotificationCenter defaultCenter] postNotificationName:ChangeImageIvNoti object:self.status];
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
#pragma mark  - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.classChoseBtn.titleLabel.text isEqualToString:@"选择学科V"]) {
        [HUDManager  showWarningWithText:@"请选择科目"];
        return NO;
    }
    if (self.otherBtns.count >0) {
        for (UIButton *btn in self.otherBtns) {
            if ([btn.titleLabel.text isEqualToString:@"选择学科V"]) {
                [HUDManager  showWarningWithText:@"请选择科目"];
                return NO;
            }
        }
    }
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger num = [textField.text integerValue];
    if (num>100 ) {
//        [HUDManager showWarningWithText:@"请输入100以内的分数!"];
//        textField.text = nil;
        return NO;
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSInteger num = [textField.text integerValue];
//    if (self.gradeTF != textField) {
//        if (num>100 ||num <= 0 ) {
//            [HUDManager showWarningWithText:@"请输入100以内的分数!"];
//            textField.text = nil;
//            return YES;
//        }
//    }
    return YES;
}
#pragma mark  - ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString level1:(NSString *)level1 row1:(NSInteger)row1 row2:(NSInteger)row2{
    
    self.model = self.subjectModelArray[row1];
    //记录classId 学科名字
    if (self.otherBtns.count==0) {
        self.classid = self.model.cityId;
        self.className = resultString;
    }else{
        self.classid = [self.classid stringByAppendingString:[NSString stringWithFormat:@",%@",self.model.cityId]];
        self.className = [self.className stringByAppendingString:[NSString stringWithFormat:@",%@",resultString]];
    }
    
    if (self.classPick == pickView) {//默认学科按钮
        [self.classChoseBtn setTitle:resultString forState:UIControlStateNormal];
    }
    if (self.otherPick == pickView) {//新添加学科按钮
        
        UIButton *classbtn = self.otherBtns[self.few-1];
        [classbtn setTitle:resultString forState:UIControlStateNormal];
        
    }
    
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
            btn.selected = YES;
            if (btn.tag > sender.tag) {
                btn.selected = NO;
            }
        if (sender.tag == btn.tag) {
            self.behavior = [NSString stringWithFormat:@"%ld",btn.tag-100];
        }
    }

}
/**
 * 学习评价
 */
- (IBAction)studyCommentAction:(UIButton *)sender {

    for (UIButton *btn in self.studyStarts) {
        btn.selected = YES;
        if (btn.tag > sender.tag) {
            btn.selected = NO;
        }
        if (sender.tag == btn.tag) {
            self.study = [NSString stringWithFormat:@"%ld",btn.tag-105];
        }
    }

}
/**
 * 总结按钮
 */
- (IBAction)sumupAction:(UIButton *)sender {
    
    if (self.followmodel == nil) {
        [HUDManager showWarningWithText:@"请先签到"];
        return;
    }
    if (![self.classChoseBtn.titleLabel.text isEqualToString:@"选择学科V"]&& self.otherTF.count==0) {
        if ([self.gradeTF.text integerValue]>100 ||[self.gradeTF.text integerValue]<=0) {
            [HUDManager  showWarningWithText:@"请输入100以内的分数!"];
            return ;
        }
    }

    if (self.otherTF.count>0) {
        UITextField *classTf = [self.otherTF lastObject];
        if (classTf.text.length==0 || [[classTf.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            [HUDManager  showWarningWithText:@"请输入100以内的分数!"];
            return;
        }
    }

    //记录分数
    self.classGrade = self.gradeTF.text;
    for (UITextField *tf in self.otherTF) {
        self.classGrade = [self.classGrade stringByAppendingString:[NSString stringWithFormat:@",%@",tf.text]];
    }
    //记录学科
    self.className = self.classChoseBtn.titleLabel.text;
    if (self.otherBtns.count > 0) {
        for (UIButton *btn in self.otherBtns) {
            self.className = [self.className stringByAppendingString:[NSString stringWithFormat:@",%@",btn.titleLabel.text]];
        }
    }

    [HUDManager showLoadingHUDView:KeyWindow];
    if ([self.followmodel.status isEqualToString:@"2"]||[self.followmodel.status isEqualToString:@"1"]) {
        self.status = @"2";
        self.statusName =@"总结";
        [self.apiChange setApiParamsWithId:self.followmodel.kid
                                     leave:@""
                                leaveImage:@""
                                workStatus:self.workStatus
                            workStatusName:self.workStatusName
                                  behavior:self.behavior
                                     study:self.study
                                     grade:self.classGrade
                                   subject:self.classid
                               subjectName:self.className
                                    status:self.status
                                statusName:self.statusName
                                    signIn:@""
                               signInImage:@""
                                      note:self.remarkTV.text
                             summaryPerson:self.loginName
                               leavePerson:@""];

    }
    if ([self.followmodel.status isEqualToString:@"3"]) {
        self.status = @"3";
        self.statusName =@"离校";
        [self.apiChange setApiParamsWithId:self.followmodel.kid
                                     leave:@""
                                leaveImage:@""
                                workStatus:self.workStatus
                            workStatusName:self.workStatusName
                                  behavior:self.behavior
                                     study:self.study
                                     grade:self.classGrade
                                   subject:self.classid
                               subjectName:self.className
                                    status:self.status
                                statusName:self.statusName
                                    signIn:@""
                               signInImage:@""
                                      note:self.remarkTV.text
                             summaryPerson:@""
                               leavePerson:self.loginName];

    }
    [APIClient execute:self.apiChange];

}
/**
 * 添加其他学科（按钮 文本框）
 */
- (IBAction)addClassAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self.gradeTF.text integerValue]>100 ||[self.gradeTF.text integerValue]<=0) {
        [HUDManager showWarningWithText:@"请输入100以内的分数!"];
        self.gradeTF.text = nil;
        return;
    }
    
    if (self.otherBtns.count>0) {
        UIButton *classbtn = [self.otherBtns lastObject];
        if ([classbtn.titleLabel.text isEqualToString:@"选择学科V"]) {
            [HUDManager  showWarningWithText:@"请填写添加的科目和分数!"];
            return ;
        }
    }
    if (self.otherTF.count>0) {
        UITextField *classTf = [self.otherTF lastObject];
        if (classTf.text.length==0 || [[classTf.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
          [HUDManager  showWarningWithText:@"请填写分数!"];
            return;
        }
        for (UITextField *te in self.otherTF) {
            if ([te.text integerValue]>100 ||[te.text integerValue]<=0) {
                [HUDManager showWarningWithText:@"请输入100以内的分数!"];
                te.text = nil;
                return;
            }
        }
    }
    if (self.gradeTF.text.length ==0|| [[self.gradeTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager  showWarningWithText:@"请填写学科分数!"];
        return;
    }
    if (self.count>2) {
        [HUDManager showWarningWithText:@"选择太多学科了！"];
        return;
    }
    if ([self.classChoseBtn.titleLabel.text isEqualToString:@"选择学科V"]) {
        [HUDManager  showWarningWithText:@"请填写科目和分数!"];
        return ;
    }
    
    self.viewHeightLayout.constant = self.viewHeightLayout.constant +ClassViewHeight;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.classChoseBtn.frame.origin.x, self.classChoseBtn.frame.origin.y+ClassViewHeight*self.count, self.classChoseBtn.frame.size.width, self.classChoseBtn.frame.size.height)];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitle:@"选择学科V" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.tag = self.count;
    [btn addTarget:self action:@selector(classChoseAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.otherBtns addObject:btn];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(self.gradeTF.frame.origin.x, self.gradeTF.frame.origin.y+ClassViewHeight*self.count, self.gradeTF.frame.size.width, self.gradeTF.frame.size.height)];
    tf.delegate = self;
    tf.tag = self.count;
    tf.font = [UIFont systemFontOfSize:14];
    tf.placeholder = @"分数";
    [tf setKeyboardType:UIKeyboardTypeNumberPad];;
    [self.otherTF addObject:tf];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.gradeTF.frame.origin.x, self.gradeTF.frame.origin.y+ClassViewHeight*self.count+ClassViewHeight, self.gradeTF.frame.size.width, 1)];
    view.backgroundColor = kBGColor;
    [self.otherView addObject:view];
    
    self.count++;
    [self.classView addSubview:btn];
    [self.classView addSubview:tf];
    [self.classView addSubview:view];
    
}
/**
 * 学科选择按钮
 */
- (IBAction)classChoseAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    [_classPick remove];
    [_otherPick remove];
    
    //记录选择的第几个按钮
    self.few = sender.tag;
    if (sender.tag == 0) {//默认学科按钮
        _classPick=[[ZHPickView alloc] initPickviewWithArray:self.subjectArray isHaveNavControler:NO];
        _classPick.delegate=self;
        [_classPick show];
    }else{//后来添加的学科按钮
        _otherPick=[[ZHPickView alloc] initPickviewWithArray:self.subjectArray isHaveNavControler:NO];
        _otherPick.delegate=self;
        [_otherPick show];
    }
    

}


#pragma mark - private methods

- (void)changeViewInfoNotification:(NSNotification *)noti{
    
    for (UIButton *btn in self.otherBtns) {
        [btn removeFromSuperview];
    }
    for (UITextField *tf in self.otherTF) {
        [tf removeFromSuperview];
    }
    for (UIView *v in self.otherView) {
        [v removeFromSuperview];
    }
    [self.xuekes removeAllObjects];
    [self.fenshus removeAllObjects];
    [self.otherBtns removeAllObjects];
    [self.otherTF removeAllObjects];
    [self.otherView removeAllObjects];
    self.viewHeightLayout.constant = ClassViewHeight;

    
    FollowModel *info = noti.object;
    self.followmodel = info;
    if (info != nil) {
        //设置界面
        self.remarkTV.text = info.note;
        if ([self.followmodel.workStatus isEqualToString:@"1"]) {
            self.completeBtn.selected = YES;
            self.uncompleteBtn.selected = NO;
        }
        //分隔字符串 加入学科数组  分数数字
        self.className = self.followmodel.subjectName;
        self.classGrade = self.followmodel.grade;
        
       NSArray *xuekeArray = [self.followmodel.subjectName componentsSeparatedByString:@","];
        [self.xuekes removeAllObjects];
        for (NSString *str in xuekeArray) {
            if (![[ValueUtils stringFromObject:str] isEqualToString:@""]) {
                [self.xuekes addObject:str];
            }
        }
        NSArray *fenshuArray = [self.followmodel.grade componentsSeparatedByString:@","];
        [self.fenshus removeAllObjects];
        for (NSString *str in fenshuArray) {
            if (![[ValueUtils stringFromObject:str] isEqualToString:@""]) {
                [self.fenshus addObject:str];
            }
        }
        
        if (self.xuekes.count > 1) {
            self.count = self.xuekes.count;
        }else{
            self.count = 1;
        }
        if (self.otherBtns.count == 0 ) {
            //创建相应的学科分数按钮文本框
            for (int i = 1 ;  i<self.count ; i++) {
                self.viewHeightLayout.constant = self.viewHeightLayout.constant +ClassViewHeight;
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.classChoseBtn.frame.origin.x, self.classChoseBtn.frame.origin.y+ClassViewHeight*i, self.classChoseBtn.frame.size.width, self.classChoseBtn.frame.size.height)];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitle:self.xuekes[i] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                btn.tag = i;
                [btn addTarget:self action:@selector(classChoseAction:) forControlEvents:UIControlEventTouchUpInside];
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [self.otherBtns addObject:btn];
                
                if (i<self.fenshus.count) {
                    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(self.gradeTF.frame.origin.x, self.gradeTF.frame.origin.y+ClassViewHeight*i, self.gradeTF.frame.size.width, self.gradeTF.frame.size.height)];
                    tf.delegate = self;
                    tf.tag = self.count;
                    tf.font = [UIFont systemFontOfSize:14];
                    tf.text = fenshuArray[i];
                    tf.placeholder = @"分数";
                    [tf setKeyboardType:UIKeyboardTypeNumberPad];
                    [self.otherTF addObject:tf];
                    
                    [self.classView addSubview:tf];

                }
//                else{
//                    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(self.gradeTF.frame.origin.x, self.gradeTF.frame.origin.y+ClassViewHeight*i, self.gradeTF.frame.size.width, self.gradeTF.frame.size.height)];
//                    tf.delegate = self;
//                    tf.tag = self.count;
//                    tf.font = [UIFont systemFontOfSize:14];
//                    tf.placeholder = @"分数";
//                    [self.otherTF addObject:tf];
//                    
//                    [self.classView addSubview:tf];
//
//                }
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.gradeTF.frame.origin.x, self.gradeTF.frame.origin.y+ClassViewHeight*i+ClassViewHeight, self.gradeTF.frame.size.width, 1)];
                view.backgroundColor = kBGColor;
                [self.otherView addObject:view];
                
                [self.classView addSubview:view];
                [self.classView addSubview:btn];
                
                
            }

        }
        
        
        //设置学科按钮
        if ([self.followmodel.subjectName isEqualToString:@""]) {
            [self.classChoseBtn setTitle:@"选择学科V" forState:UIControlStateNormal];
        }else{
            [self.classChoseBtn setTitle:self.xuekes[0] forState:UIControlStateNormal];
        }
        
        //设置学科分数
        if (![self.followmodel.grade isEqualToString:@"0"]) {
            self.gradeTF.text = self.fenshus[0];
        }else {
            self.gradeTF.text = nil;
        }
        //设置星星显示
        NSInteger num1 = [self.followmodel.behavior integerValue]+100;
        for (UIButton *btn in self.xingweiStarts) {
            btn.selected = YES;
            if (btn.tag > num1) {
                btn.selected = NO;
            }
            if (num1 == btn.tag) {
                self.study = [NSString stringWithFormat:@"%ld",btn.tag-100];
            }
        }
        NSInteger num2 = [self.followmodel.study integerValue]+105;
        for (UIButton *btn in self.studyStarts) {
            btn.selected = YES;
            if (btn.tag > num2) {
                btn.selected = NO;
            }
            if (num2 == btn.tag) {
                self.study = [NSString stringWithFormat:@"%ld",btn.tag-105];
            }
        }

        
    }
    if (info == nil) {
        for (UIButton *btn in self.xingweiStarts) {
            btn.selected = YES;
        }
        for (UIButton *btn in self.studyStarts) {
            btn.selected = YES;
        }
        self.behavior = @"5";
        self.study = @"5";
        self.workStatus = @"1";
        self.completeBtn.selected = YES;
        self.workStatusName = @"完成作业";
        self.gradeTF.text = nil;
        self.remarkTV.text = @"";
        self.uncompleteBtn.selected = NO;
        [self.classChoseBtn setTitle:@"选择学科V" forState:UIControlStateNormal];
    }
    
}


@end
