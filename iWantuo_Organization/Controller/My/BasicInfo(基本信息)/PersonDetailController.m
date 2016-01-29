//
//  PersonDetailController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "PersonDetailController.h"
#import "ApiChangeArganization.h"
#import "CityInfoModel.h"
#import "ApiAddressListRequest.h"
#import "ZHPickView.h"
#import "ApiOrganizationInfoRequest.h"
#import "AccountModel.h"
#import "CameraTakeMamanger.h"
#import "UploadManager.h"

@interface PersonDetailController ()<APIRequestDelegate,ZHPickViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;//地区按钮
@property (weak, nonatomic) IBOutlet UITextField *areaTF;//地区TF
@property (weak, nonatomic) IBOutlet UITextField *nameTF;//机构全称TF
@property (weak, nonatomic) IBOutlet UITextField *describeTF;//机构描述
@property (weak, nonatomic) IBOutlet UITextField *tagTF;//机构标签
@property (weak, nonatomic) IBOutlet UITextField *priceTF;//机构价格
@property (weak, nonatomic) IBOutlet UITextField *adressTF;//详细地址
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;//电话
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;//机构类型按钮
@property (weak, nonatomic) IBOutlet UITextField *typeTF;//机构类型tf
@property (weak, nonatomic) IBOutlet UIImageView *imageIV1;
@property (weak, nonatomic) IBOutlet UIImageView *imageIV2;
@property (weak, nonatomic) IBOutlet UIImageView *imageIV3;

@property (nonatomic, strong) ApiChangeArganization *apiChange;//修改信息接口
@property (nonatomic, strong) ApiAddressListRequest *apiCity;//获取地区接口
@property (nonatomic, strong) ApiOrganizationInfoRequest *apiInfo;//查询信息接口
@property (nonatomic, strong) NSMutableArray *areaArray;//地区数组
@property (nonatomic, strong) NSMutableArray *areaModelArry;//地区模型数组
@property (nonatomic, strong) ZHPickView *areaPick;//地球选择器
@property (nonatomic, strong) ZHPickView *typePick;//机构类型选择器
@property (nonatomic, strong) AccountModel *model;
@property (nonatomic, copy) NSString *organiType;//机构类型 15工作室 16公司
@property (nonatomic, copy) NSString *organiTypeName;//类型名称
@property (nonatomic, copy) NSString *areaId;//区域id
@property (nonatomic, copy) NSString *areaName;//区域名称
@property (nonatomic, copy) NSString *imageName;//记录图片名称
@property (nonatomic, copy) NSString *imageNameUrl;
@property (nonatomic, copy) NSString *imageName1;
@property (nonatomic, copy) NSString *imageName2;
@property (nonatomic, copy) NSString *imageName3;
@end

@implementation PersonDetailController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"基本信息";
    self.areaArray = [NSMutableArray array];
    self.areaModelArry = [NSMutableArray array];
    //修改头像 手势
    self.imageIV1.userInteractionEnabled = YES;
    self.imageIV2.userInteractionEnabled = YES;
    self.imageIV3.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage1:)];
    UITapGestureRecognizer *singleTap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage2:)];
    UITapGestureRecognizer *singleTap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage3:)];
    [self.imageIV1 addGestureRecognizer: singleTap1];
    [self.imageIV2 addGestureRecognizer: singleTap2];
    [self.imageIV3 addGestureRecognizer: singleTap3];

    
    //区域请求接口
    [HUDManager showLoadingHUDView:self.view];
    self.apiCity = [[ApiAddressListRequest alloc]initWithDelegate:self];
    [self.apiCity setApiParamsWithParentId:@"3"];
    [APIClient execute:self.apiCity];
    //机构信息请求接口
    self.apiInfo = [[ApiOrganizationInfoRequest alloc]initWithDelegate:self];
    [self.apiInfo setApiParamsWithLoginAccounts:[AccountManager sharedInstance].account.loginAccounts currentLogin:[AccountManager sharedInstance].account.loginAccounts];
    [APIClient execute:self.apiInfo];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
    [self.areaPick remove];
    [self.typePick remove];
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
    if (api == self.apiCity) {//地区列表
        NSArray *array = [sr.dic objectForKey:@"sysCodeList"];
        for (NSDictionary *dic in array) {
            CityInfoModel *model = [CityInfoModel initWithDic:dic];
            [self.areaArray addObject:model.name];
            [self.areaModelArry addObject:model];
        }
    }
    if (api == self.apiInfo) {//查询机构信息接口
        NSDictionary *dic = [sr.dic objectForKey:@"organization"];
        //解析model ->在界面显示
        self.model = [AccountModel initWithDict:dic accountType:@"2"];
        [self initstallView];
        
    }
    if (api == self.apiChange) {//信息修改接口
        
        [AlertViewManager showAlertViewSuccessedMessage:@"修改成功" handlerBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
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
    
    if (pickView == self.areaPick) {
        CityInfoModel *cityModel = self.areaModelArry[row1];
        self.areaId = cityModel.cityId;
        self.areaName = cityModel.name;
        self.areaTF.text = resultString;
    }
    if (pickView == self.typePick) {
        if ([resultString isEqualToString:@"公司"]) {
            self.organiType = @"16";
        }
        if ([resultString isEqualToString:@"工作室"]) {
            self.organiType = @"15";
        }
        self.typeTF.text = resultString;
        self.organiTypeName = resultString;
    }
        
}


#pragma mark - event response
/**区域选择按钮*/
- (IBAction)areaBtnAction:(UIButton *)sender {
    [_areaPick remove];
    [_typePick remove];
    [self.view endEditing:YES];
    
    _areaPick=[[ZHPickView alloc]initPickviewWithArray:self.areaArray isHaveNavControler:NO];
    _areaPick.delegate=self;
    [_areaPick show];

    
}
/**机构类型按钮*/
- (IBAction)typeBtnAction:(UIButton *)sender {
    [_areaPick remove];
    [_typePick remove];
    [self.view endEditing:YES];
    
    _typePick=[[ZHPickView alloc]initPickviewWithArray:@[@"公司",@"工作室"] isHaveNavControler:NO];
    _typePick.delegate=self;
    [_typePick show];

}
/**提交修改按钮*/
- (IBAction)commitBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    [self.areaPick remove];
    [self.typePick remove];
    
    [HUDManager showLoadingHUDView:self.view];
    self.apiChange = [[ApiChangeArganization alloc]initWithDelegate:self];
    [self.apiChange setApiParamsWithLoginAccounts:[AccountManager sharedInstance].account.loginAccounts
                                         location:@"3"
                                     locationName:@"上海市"
                                           bairro:self.areaId
                                       bairroName:self.areaName
                                          address:self.adressTF.text
                                  organizatioType:self.organiType
                              organizatioTypeName:self.organiTypeName
                                     organization:self.nameTF.text
                                            phone:self.phoneTF.text
                                        introduce:self.describeTF.text
                                            label:self.tagTF.text
                                       photoAlbum:self.imageName
                                             cost:self.priceTF.text];
    [APIClient execute:self.apiChange];
}

#pragma mark - private methods

//根据获取的机构信息 在界面显示
- (void)initstallView{
    //记录区域 机构类型 id name 图片
    self.organiType = self.model.organizatioType;
    self.organiTypeName = self.model.organizatioTypeName;
    self.areaId = self.model.bairro;
    self.areaName = self.model.bairroName;
    //记录图片url
    self.imageNameUrl = self.model.photoAlbum;
    NSArray *imageArray = [self.model.photoAlbum componentsSeparatedByString:@","];
    for (int i = 0; i<imageArray.count; i++) {
        if (imageArray.count == 0) {
            return;
        }
        NSString *str = imageArray[i];
        if ([str hasPrefix:@"http://www"]) {
            str = str;
        }else{
            str = [NSString stringWithFormat:@"%@%@",@"http://www.",str];
        }
        if (i ==0) {
            [self.imageIV1 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"register_addImageBtn"]];
        }
        if (i ==1) {
            [self.imageIV2 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"register_addImageBtn"]];
        }
        if (i == 2) {
            [self.imageIV3 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"register_addImageBtn"]];
        }
    }
    //记录图片name
    self.imageName = self.model.pathName;
    NSArray *imageNameArray = [self.model.pathName componentsSeparatedByString:@","];
    for (int i = 0; i<imageNameArray.count; i++) {
        if (imageNameArray.count == 0) {
            return;
        }
        NSString *str = imageNameArray[i];
        if (i ==0) {
            self.imageName1 = str;
        }
        if (i ==1) {
            self.imageName2 = str;
        }
        if (i == 2) {
            self.imageName3 = str;
         }
    }

    //设置界面显示内容
    self.typeTF.text = self.organiTypeName;
    self.areaTF.text = self.areaName;
    self.nameTF.text = self.model.organization;
    self.describeTF.text = self.model.introduce;
    self.tagTF.text = self.model.label;
    self.priceTF.text = self.model.cost;
    self.adressTF.text = self.model.address;
    self.phoneTF.text = self.model.phone;
}
/**
 *  上传ImageView
 *
 *  @param tap 单击手势
 */
- (void)changeImage1:(UITapGestureRecognizer*)singleTapGestureRecognizer{
    [self cameraAndUploadImage:self.imageIV1];
}
- (void)changeImage2:(UITapGestureRecognizer*)singleTapGestureRecognizer{
    [self cameraAndUploadImage:self.imageIV2];
}
- (void)changeImage3:(UITapGestureRecognizer*)singleTapGestureRecognizer{
    [self cameraAndUploadImage:self.imageIV3];
}
- (void)cameraAndUploadImage:(UIImageView *)imageIv{
    [self.view endEditing:YES];
    //上传图片
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        
        [HUDManager showLoadingHUDView:self.view];
        [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *fileUrl, NSString *serverUrl, NSString *message) {
            [HUDManager hideHUDView];
            if (fileUrl == nil || [fileUrl isKindOfClass:[NSNull class]]) {
                [AlertViewManager showAlertViewWithMessage:@"服务器异常,请稍后重试"];
                return ;
            }
            if (imageIv.tag == 101) {
                self.imageName1 = message;
            }
            if (imageIv.tag == 102) {
                self.imageName2 = message;
            }
            if (imageIv.tag == 103) {
                self.imageName3 = message;
            }
            // 记录图片地址  设置图片
            self.imageName = [NSString stringWithFormat:@"%@,%@,%@",self.imageName1,self.imageName2,self.imageName3];
            imageIv.image = image;
            
        } failure:^(NSString *message) {
            [HUDManager showWarningWithText:@"上传失败！请重试！"];
            [HUDManager hideHUDView];
        }];
    } cancelHandler:^{
        
    }];

}
@end
