//
//  SubmitInfoViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "SubmitInfoViewController.h"
#import "ZHPickView.h"
#import "ApiRegisterRequest.h"
#import "ApiAddressListRequest.h"
#import "CityInfoModel.h"
#import "LoginViewController.h"

@interface SubmitInfoViewController ()<ZHPickViewDelegate,APIRequestDelegate>
/**工作室*/
@property (weak, nonatomic) IBOutlet UIButton *workRoomBtn;
/**公司*/
@property (weak, nonatomic) IBOutlet UIButton *companyBtn;
/**简称*/
@property (weak, nonatomic) IBOutlet UITextField *shortNameTF;
/**全称*/
@property (weak, nonatomic) IBOutlet UITextField *FullNameTF;
/**真实姓名*/
@property (weak, nonatomic) IBOutlet UITextField *trueNameTF;
/**详细地址*/
@property (weak, nonatomic) IBOutlet UITextField *detialAdressTF;
/**邮箱*/
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
/**身份证*/
@property (weak, nonatomic) IBOutlet UIButton *cardIdBtn;
/**执照*/
@property (weak, nonatomic) IBOutlet UIButton *licenseBtn;
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;
/**添加图片按钮*/
@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;
@property (weak, nonatomic) IBOutlet UITextField *connectTF;//联系电话
//地区
@property (weak, nonatomic) IBOutlet UITextField *areaTF;

@property(nonatomic,strong)ZHPickView *pickview;//可选地区Pickview
@property (nonatomic, strong) ApiRegisterRequest *apiRegister;//注册
@property (nonatomic, strong) ApiAddressListRequest *apiAddressList;//地区列表
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSMutableArray *areaArray;//地区数组
@property (nonatomic, strong) NSMutableArray *areaModelArry;//区域model数组
@property (nonatomic, assign) NSInteger number;//记录地区数组选中

@property (nonatomic, copy) NSString *organiType;//记录机构类型id
@property (nonatomic, copy) NSString *organiTypeName;//记录机构名称
@property (nonatomic, copy) NSString *imageName;//记录图片名称（多张上传接口只穿名称）
@end

@implementation SubmitInfoViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提交资料";
    self.workRoomBtn.selected = YES;
    self.cardIdBtn.selected = YES;
    self.addressArray = [NSMutableArray array];
    self.areaArray = [NSMutableArray array];
    self.areaModelArry = [NSMutableArray array];
    
    self.organiType = @"15";
    self.organiTypeName = @"工作室";

    //添加手势
    UITapGestureRecognizer *ontTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(swapLabels:)];
    ontTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:ontTap];
    
    //获得地区列表 固定设置为上海市 的地区
    self.apiAddressList = [[ApiAddressListRequest alloc]initWithDelegate:self];
    [self.apiAddressList setApiParamsWithParentId:@"3"];
    [APIClient execute:self.apiAddressList];
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
    [self.pickview remove];
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
    if (api == self.apiAddressList) {//地区列表
        NSArray *array = [sr.dic objectForKey:@"sysCodeList"];
        for (NSDictionary *dic in array) {
            CityInfoModel *model = [CityInfoModel initWithDic:dic];
            [self.areaArray addObject:model.name];
            [self.areaModelArry addObject:model];
        }

    }
    
    if (api == self.apiRegister) {//注册
        
        [HUDManager showWarningWithText:@"感谢您的申请，我们会在24小时内为您开通账号"];
//        LoginViewController *vc = [[LoginViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
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
    self.number = row2;
    self.areaTF.text = [NSString stringWithFormat:@"%@%@",@"上海市",resultString];
}

#pragma mark - event response
/**
 *  机构类型按钮
 */
- (IBAction)organizationTypeBtns:(UIButton *)sender {
    sender.selected = YES;
    switch (sender.tag) {
        case 101://工作室
            self.organiType = @"15";
            self.organiTypeName = @"工作室";
            self.companyBtn.selected = NO;
            break;
            
        case 102://公司
            self.organiType = @"16";
            self.organiTypeName = @"公司";
            self.workRoomBtn.selected = NO;
            break;
    }
}
/**
 *  证件按钮
 */
- (IBAction)certificateBtns:(UIButton *)sender {
    sender.selected = YES;
    switch (sender.tag) {
        case 103://身份证
            self.licenseBtn.selected = NO;
            break;
            
        case 104://营业执照
            self.cardIdBtn.selected = NO;
            break;
    }

}
/**
 *  上传图片按钮
 */
- (IBAction)upLoadImageBtn:(UIButton *)sender {
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
            self.imageIV.image = image;
            [self.addImageBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
        } failure:^(NSString *message) {
            [HUDManager showWarningWithText:message];
            [HUDManager hideHUDView];
        }];
    } cancelHandler:^{
        
    }];

}
/**
 *  提交按钮
 */
- (IBAction)commitBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    [self.pickview remove];
    //校验 提交
    if (![self dataCheck]) {
        return;
    }
    
    CityInfoModel *model = self.areaModelArry[self.number];
    self.apiRegister = [[ApiRegisterRequest alloc]initWithDelegate:self];
    [self.apiRegister setApiParamsWithLoginAccount:self.phoneNum
                                          password:self.passWord
                                           address:self.detialAdressTF.text
                                             email:self.emailTF.text
                          organizationAbbreviation:self.shortNameTF.text
                                      organization:self.FullNameTF.text
                              organizationContacts:self.trueNameTF.text
                                      locationName:@"上海市"
                                          location:@"3"
                                            bairro:model.cityId
                                        bairroName:model.name
                                   organizatioType:self.organiType
                               organizatioTypeName:self.organiTypeName
                                       idCardImage:self.imageName
                                             phone:self.connectTF.text];
    [APIClient execute:self.apiRegister];
}

//选择地区
- (IBAction)areaBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    [_pickview remove];
    NSArray *array=@[@[@"上海市"],self.areaArray];
    _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _pickview.delegate=self;
    [_pickview show];
}

#pragma mark - private methods
- (void)swapLabels:(UITapGestureRecognizer *)tap{
    [self.pickview remove];
}

- (BOOL)dataCheck{
    if (self.shortNameTF.text.length == 0 ||[[self.shortNameTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入机构简称"];
        return NO;
    }
    
    if (self.FullNameTF.text.length == 0 ||[[self.FullNameTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入机构全称"];
        return NO;
    }
    if (self.trueNameTF.text.length == 0 ||[[self.trueNameTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入真实姓名"];
        return NO;
    }
    if (self.detialAdressTF.text.length == 0 ||[[self.detialAdressTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入详细地址"];
        return NO;
    }
    if (self.emailTF.text.length == 0 ||[[self.emailTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入邮箱"];
        return NO;
    }
    if (![NSString tf_isValidateEmail:self.emailTF.text]) {
        [HUDManager showWarningWithText:@"请输入正确邮箱地址"];
        return NO;
    }
    if (self.shortNameTF.text.length>10) {
        [HUDManager showWarningWithText:@"请输入10字以内的简称"];
        return NO;
    }
    if (self.FullNameTF.text.length>30) {
        [HUDManager showWarningWithText:@"请输入30字以内的全称"];
        return NO;
    }
    if (self.areaTF.text.length == 0) {
        [HUDManager showWarningWithText:@"请选择地区"];
        return NO;
    }
    if (self.connectTF.text.length == 0 ||[[self.connectTF.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入联系方式"];
        return NO;
    }
    if (self.imageName.length == 0) {
        [HUDManager showWarningWithText:@"请上传图片"];
        return NO;
    }
    
    if ([self.shortNameTF.text containsString:[NSString specialBlankCharacter]] ||
        [self.FullNameTF.text containsString:[NSString specialBlankCharacter]] ||
        [self.trueNameTF.text containsString:[NSString specialBlankCharacter]] ||
        [self.detialAdressTF.text containsString:[NSString specialBlankCharacter]] ||
        [self.emailTF.text containsString:[NSString specialBlankCharacter]]) {
        [HUDManager showWarningWithText:@"暂不支持系统表情哦~"
         ];
        return NO;
    }
    
    return YES;
}

@end
