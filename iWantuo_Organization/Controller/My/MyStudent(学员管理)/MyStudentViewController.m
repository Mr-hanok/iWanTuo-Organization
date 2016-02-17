//
//  MyStudentViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyStudentViewController.h"
#import "AddStudentCell.h"
#import "ApiSaveStudentRequest.h"
#import "TFDatePickerView.h"
#import "AccountListViewController.h"
#import "ZHPickView.h"
#import "ApiAddressListRequest.h"
#import "CityInfoModel.h"
#import "NSString+Verify.h"
#import "ApiGetStudentInfoRequest.h"
#import "ApiUpdateStudentRequest.h"
#import "PatriarchModel.h"


#define kAddStudentCellReuse  @"AddStudentCellReuse"
@interface MyStudentViewController ()<APIRequestDelegate, TFDatePickerViewDelegate,  UITextFieldDelegate, ZHPickViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;
@property (weak, nonatomic) IBOutlet UITextField *gradeTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *parentAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *parentSexTextField;
@property (weak, nonatomic) IBOutlet UITextField *otherRelationTextField;
@property (weak, nonatomic) IBOutlet UITextField *otherPhoneTextField;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) TFDatePickerView *pickView;
@property (nonatomic, strong) NSMutableArray *areaArray;
@property (nonatomic, strong) NSMutableArray *areaModelArry;
@property(nonatomic,strong)ZHPickView *pickviewArea;//可选地区Pickview
@property(nonatomic,strong)ZHPickView *pickviewSex;//可选性别Pickview
@property(nonatomic,strong)ZHPickView *pickviewGrade;//可选年级Pickview

@property (nonatomic, strong) ApiSaveStudentRequest *apiSaveStudent;
@property (nonatomic, strong) ApiAddressListRequest *apiAddressList;//地区列表
@property (nonatomic, strong) ApiGetStudentInfoRequest *apiStudentInfo;
@property (nonatomic, strong) ApiUpdateStudentRequest *apiUpdateStudent;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSString *patriarchId;

@end

@implementation MyStudentViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.sex = @"1";
        self.areaArray = [NSMutableArray array];
        self.areaModelArry = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.otherPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.pickView = [TFDatePickerView tfDatePickerViewWithDatePickerMode:UIDatePickerModeDate Delegate:self];
    [self.view bk_whenTapped:^{
        [self.pickviewSex remove];
        [self hiddenKeyBoard];
    }];
    
    //获得地区列表 固定设置为上海市 的地区
    self.apiAddressList = [[ApiAddressListRequest alloc]initWithDelegate:self];
    [self.apiAddressList setApiParamsWithParentId:@"3"];
    [APIClient execute:self.apiAddressList];
//    [HUDManager showLoadingHUDView:KeyWindow];
    
    if (self.infoType == AddInfoType) {
        self.title = @"添加学员";
        
        self.sexTextField.text = @"男";
        self.gradeTextField.text = @"小学一年级";
        self.parentSexTextField.text = @"父亲";

    } else if (self.infoType == UpdateInfoType) {
        self.title = @"修改学员信息";
        self.timeTextField.userInteractionEnabled = NO;
        self.apiStudentInfo = [[ApiGetStudentInfoRequest alloc] initWithDelegate:self];
        //判断是老师还是机构
        if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {//老师
            [self.apiStudentInfo setApiParmsWithStudentId:self.studentId organizationAccounts:[AccountManager sharedInstance].account.organizationAccounts];
        }else {//机构

            [self.apiStudentInfo setApiParmsWithStudentId:self.studentId organizationAccounts:[AccountManager sharedInstance].account.loginAccounts];
        }

        
        [APIClient execute:self.apiStudentInfo];
        [HUDManager showLoadingHUDView:KeyWindow];
    
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
    
   
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
    [self.pickviewArea remove];
    [self.pickviewGrade remove];
    [self.pickviewSex remove];
}
#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString level1:(NSString *)level1 row1:(NSInteger)row1 row2:(NSInteger)row2{

    if (pickView == self.pickviewSex) {
        self.sexTextField.text = resultString;
    } else if (pickView == self.pickviewArea) {
        self.locationTextField.text = resultString;
    } else if (pickView == self.pickviewGrade) {
        self.gradeTextField.text = resultString;
    }
    NSLog(@"%@-%@-%ld-%ld",resultString,level1,row1,row2);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.timeTextField) {
        [self hiddenKeyBoard];
        [self.pickView tf_show];
        return NO;
    } else if (textField == self.sexTextField) {
        //选择性别
        [self hiddenKeyBoard];
        self.pickviewSex = [[ZHPickView alloc] initPickviewWithArray:@[@"男", @"女"] isHaveNavControler:NO];
        self.pickviewSex.delegate = self;
        [self.pickviewSex show];
        return NO;
        
    } else if (textField == self.gradeTextField) {
        //选择年ji
        [self hiddenKeyBoard];
        self.pickviewGrade = [[ZHPickView alloc] initPickviewWithArray:@[@"学前班大班", @"学前班小班", @"小学一年级", @"小学二年级", @"小学三年级", @"小学四年级", @"小学五年级", @"小学六年级", @"初中一年级", @"初中二年级", @"初中三年级"] isHaveNavControler:NO];
        self.pickviewGrade.delegate = self;
        [self.pickviewGrade show];
        return NO;
        
    } else if (textField == self.parentAccountTextField) {
        //绑定账号
        [self hiddenKeyBoard];
        
        void(^backBlock)(PatriarchModel *model) = ^(PatriarchModel *model){
            self.parentAccountTextField.text = model.loginAccounts;
            self.patriarchId = model.patriarchId;
        };
        
        AccountListViewController *listVC = [[AccountListViewController alloc] init];
        //设置block
        listVC.backBlock = backBlock;
        [self.navigationController pushViewController:listVC animated:YES];
        return NO;
    } else if (textField == self.locationTextField) {
        //地址
        [self hiddenKeyBoard];
        self.pickviewArea = [[ZHPickView alloc] initPickviewWithArray:self.areaArray isHaveNavControler:NO];
        self.pickviewArea.delegate = self;
        [self.pickviewArea show];

        return NO;
        
    }

    return YES;
}

#pragma mark - TFDatePickerViewDelegate

- (BOOL)submitWithSelectedDate:(NSDate *)selectedDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    outputFormatter.dateFormat       = @"yyyy-MM-dd";
    NSString *str                    = [outputFormatter stringFromDate:selectedDate];
    self.timeTextField.text          = str;
    NSLog(@"%@",str);
    self.time = [NSString stringWithFormat:@"%.0f", selectedDate.timeIntervalSince1970];
    return YES;
}


#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    
    [HUDManager hideHUDView];
    
    if (api == self.apiStudentInfo) {
        [HUDManager showWarningWithText:kDefaultNetWorkErrorString];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [AlertViewManager showAlertViewWithMessage:kDefaultNetWorkErrorString];
    }
}

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {

    [HUDManager hideHUDView];
    
    if (sr.dic == nil || [sr.dic isKindOfClass:[NSNull class]]) {
        return;
    }
    if (api == self.apiSaveStudent) {
        [HUDManager showWarningWithText:sr.msg];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (api == self.apiAddressList){
        NSArray *array = [sr.dic objectForKey:@"sysCodeList"];
        for (NSDictionary *dic in array) {
            CityInfoModel *model = [CityInfoModel initWithDic:dic];
            [self.areaArray addObject:model.name];
            [self.areaModelArry addObject:model];
        }
    } else if (api == self.apiStudentInfo) {
        self.dataDic = [sr.dic objectForKey:@"student"];
       
        self.nameTextField.text = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"name"]];
        NSString *sexStr = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"sex"]];
        if (sexStr.integerValue == 1) {
            self.sexTextField.text = @"男";
        } else if (sexStr.integerValue == 2) {
            self.sexTextField.text = @"女";
        }
        
        self.locationTextField.text = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"bairro"]];
        self.schoolTextField.text = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"school"]];
        self.gradeTextField.text = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"grade"]];
        self.timeTextField.text = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"createDate"]];
        self.parentSexTextField.text = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"patriarch"]];;
        self.parentAccountTextField.text = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"loginAccounts"]];
        self.otherRelationTextField.text = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"kinsfolk"]];
        self.otherPhoneTextField.text = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"phone"]];
        self.patriarchId = [ValueUtils stringFromObject:[self.dataDic objectForKey:@"patriarchId"]];
    }
    
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {
    
    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }

    if (api == self.apiStudentInfo) {
        [HUDManager showWarningWithText:message];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [AlertViewManager showAlertViewWithMessage:message];
    }
}



#pragma mark - event response

- (IBAction)addStudentAction:(id)sender {
    
    if ([self check]) {
        if ([self.sexTextField.text isEqualToString:@"女"]) {
            self.sex = @"2";
        } else {
            self.sex = @"1";
        }
        //地区编号
        NSString *bairroId = @"";
        for (int i = 0; i < self.areaArray.count; i++) {
            NSString *areaName = self.areaArray[i];
            if ([areaName isEqualToString:self.locationTextField.text]) {
                CityInfoModel *model = self.areaModelArry[i];
                bairroId = model.cityId;
            }
        }
        NSString *orgLoginAccount;
        //判断是老师还是机构
        if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {//老师
            orgLoginAccount = [AccountManager sharedInstance].account.organizationAccounts;
        }else {//机构
            
            orgLoginAccount = [AccountManager sharedInstance].account.loginAccounts;
        }
        
        if (self.infoType == AddInfoType) {
            self.apiSaveStudent = [[ApiSaveStudentRequest alloc] initWithDelegate:self];
            [self.apiSaveStudent setApiParamsWithName:self.nameTextField.text school:self.schoolTextField.text grade:self.gradeTextField.text loginAccounts:self.parentAccountTextField.text patriarch:self.parentSexTextField.text phone:self.otherPhoneTextField.text sex:self.sex organizationAccounts:orgLoginAccount createDate:self.time locationId:[AccountManager sharedInstance].locationId location:@"上海" bairroId:bairroId bairro:self.locationTextField.text kinsfolk:self.otherRelationTextField.text];
            
            [APIClient execute:self.apiSaveStudent];
        } else if (self.infoType == UpdateInfoType) {
            self.apiUpdateStudent = [[ApiUpdateStudentRequest alloc] initWithDelegate:self];
            [self.apiUpdateStudent setApiParmsWithStudentId:self.studentId name:self.nameTextField.text school:self.schoolTextField.text grade:self.gradeTextField.text loginAccounts:self.parentAccountTextField.text patriarchId:self.patriarchId patriarch:self.parentSexTextField.text kinsfolk:self.sex phone:self.otherPhoneTextField.text  sex:self.sex organizationAccounts:orgLoginAccount locationId:[AccountManager sharedInstance].locationId location:@"上海" bairroId:bairroId bairro:self.locationTextField.text];
            [APIClient execute:self.apiUpdateStudent];
        }
        
        
        [HUDManager showLoadingHUDView:self.view];
    }
}

#pragma mark - private methods

- (BOOL)check {

    if (self.nameTextField.text.length <= 0  || [[self.nameTextField.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入学生姓名"];
        return NO;
    }
    if (self.locationTextField.text.length <= 0  || [[self.locationTextField.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请选择地址"];
        return NO;
    }
    if (self.schoolTextField.text.length <= 0  || [[self.schoolTextField.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入学校"];
        return NO;
    }
    if (self.timeTextField.text.length <= 0  || [[self.timeTextField.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请选择入托时间"];
        return NO;
    }
    if (self.parentAccountTextField.text.length <= 0  || [[self.parentAccountTextField.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请选择账号"];
        return NO;
    }
    if (self.otherRelationTextField.text.length <= 0  || [[self.otherRelationTextField.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入其他亲属"];
        return NO;
    }
    
    if (self.otherPhoneTextField.text.length <= 0  || [[self.otherPhoneTextField.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入其他亲属联系方式"];
        return NO;
    }
    
    if (![NSString tf_isSimpleMobileNumber:self.otherPhoneTextField.text]) {
        [HUDManager showWarningWithText:@"请输入正确的联系方式"];
        return NO;
    }
    
    return YES;
}

- (void)hiddenKeyBoard {
    [self.nameTextField resignFirstResponder];
    [self.locationTextField resignFirstResponder];
    [self.schoolTextField resignFirstResponder];
    [self.parentAccountTextField resignFirstResponder];
    [self.parentSexTextField resignFirstResponder];
    [self.otherRelationTextField resignFirstResponder];
    [self.otherPhoneTextField resignFirstResponder];
    [self.sexTextField resignFirstResponder];
    [self.gradeTextField resignFirstResponder];
}

@end
