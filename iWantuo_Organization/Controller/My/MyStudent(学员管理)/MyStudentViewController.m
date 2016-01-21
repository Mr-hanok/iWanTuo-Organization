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

#define kAddStudentCellReuse  @"AddStudentCellReuse"
@interface MyStudentViewController ()<APIRequestDelegate, TFDatePickerViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

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
@property (nonatomic, strong) UIPickerView *otherPickView;
@property (nonatomic, strong) NSMutableArray *pickArray;

@property (nonatomic, strong) ApiSaveStudentRequest *apiSaveStudent;

@end

@implementation MyStudentViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.sex = @"1";
        self.pickArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"学员管理";
    
    self.sexTextField.text = @"男";
    self.gradeTextField.text = @"小学一年级";
    self.parentSexTextField.text = @"父亲";
    
    self.pickView     = [TFDatePickerView tfDatePickerViewWithDatePickerMode:UIDatePickerModeDateAndTime Delegate:self];
    
    self.otherPickView = [[UIPickerView alloc] init];
    // 显示选中框
    
    self.otherPickView.dataSource = self;
    self.otherPickView.delegate = self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
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
        self.pickArray = [NSMutableArray arrayWithArray:@[@"男", @"女"]];
        self.otherPickView.frame = CGRectMake(0, 100, 320, 216);
        self.otherPickView.showsSelectionIndicator=YES;
        [self.view addSubview:self.otherPickView];
        
        
    } else if (textField == self.gradeTextField) {
        //选择年纪
        [self hiddenKeyBoard];
        
    } else if (textField == self.parentAccountTextField) {
        //绑定账号
        [self hiddenKeyBoard];
        
        void(^backBlock)(NSString *phone) = ^(NSString *phone){
            self.parentAccountTextField.text = phone;
        };
        
        AccountListViewController *listVC = [[AccountListViewController alloc] init];
        //设置block
        listVC.backBlock = backBlock;
        [self.navigationController pushViewController:listVC animated:YES];
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


#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickArray.count;
}

//// 每列宽度
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    
//    if (component == 1) {
//        return 40;
//    }
//    return 180;
//}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.sexTextField.text = [self.pickArray objectAtIndex:row];
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   return [self.pickArray objectAtIndex:row];
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
    [HUDManager showWarningWithText:sr.msg];
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)addStudentAction:(id)sender {
    
    if ([self check]) {
        if ([self.sexTextField.text isEqualToString:@"女"]) {
            self.sex = @"2";
        } else {
            self.sex = @"1";
        }
        self.apiSaveStudent = [[ApiSaveStudentRequest alloc] initWithDelegate:self];
        [self.apiSaveStudent setApiParamsWithName:self.nameTextField.text school:self.schoolTextField.text grade:self.gradeTextField.text loginAccounts:self.parentAccountTextField.text patriarch:self.parentSexTextField.text phone:self.otherPhoneTextField.text sex:self.sex organizationAccounts:[AccountManager sharedInstance].account.loginAccounts createDate:self.time locationId:@"3" location:@"上海" bairroId:@"" bairro:@"" kinsfolk:self.otherRelationTextField.text];
        [APIClient execute:self.apiSaveStudent];
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
}

@end
