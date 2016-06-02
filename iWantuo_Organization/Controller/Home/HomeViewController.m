//
//  HomeViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/6.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "HomeViewController.h"
#import "SharSdkManager.h"
#import "SchoolResultViewController.h"
#import "OrganizationListViewController.h"
#import "OrganizationDetailViewController.h"
#import "AddressListViewController.h"
#import "ApiAddressListRequest.h"
#import "CityInfoModel.h"


typedef enum : NSUInteger {
    SearchBySchool,
    SearchByOrganization,
    SearchByLocation,
} SearchType;

@interface HomeViewController ()<UITextFieldDelegate, BMKLocationServiceDelegate, APIRequestDelegate>
{
    BMKLocationService *_locService;
}

@property (strong, nonatomic) IBOutlet UIView *cityNameView;

@property (weak  , nonatomic) IBOutlet UIButton *cityNameBtn;
@property (strong, nonatomic) IBOutlet UIImageView *searchGlassImageView;
@property (weak  , nonatomic) IBOutlet UITextField *searchTextField;
@property (weak  , nonatomic) IBOutlet UIButton *searchBySchoolBtn;
@property (weak  , nonatomic) IBOutlet UIButton *searchByOrganizationBtn;
@property (weak  , nonatomic) IBOutlet UIButton *searchByLocationBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchTextFieldHeigthConstraint;

@property (nonatomic, assign) SearchType searchType;
@property (nonatomic, strong) ApiAddressListRequest *apiAddress;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation HomeViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.searchType = SearchBySchool;
        self.addressArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view bk_whenTapped:^{
        [self.searchTextField resignFirstResponder];
    }];
    self.cityNameView.frame = CGRectMake(0, 0, 60, 32);
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:self.cityNameView];
    
    
    [self.cityNameBtn setTitle:@"上海" forState:(UIControlStateNormal)];
    //获取城市下面的区, 存到本地.
    self.apiAddress = [[ApiAddressListRequest alloc] initWithDelegate:self];
    [self.apiAddress setApiParamsWithParentId:[AccountManager sharedInstance].locationId];
    [APIClient execute:self.apiAddress];
    
    //开始定位
    [self starLocation];
    //加载搜索框
    [self loadSearchTextField];

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(IS_IPHONE6) {
        self.searchTextFieldHeigthConstraint.constant = 38;
    } else if (IS_IPHONE6P) {
         self.searchTextFieldHeigthConstraint.constant = 42;
    } else {
         self.searchTextFieldHeigthConstraint.constant = 35;
    }
    [MobClick beginLogPageView:@"首页"];//("PageOne"为页面名称，可自定义)
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"首页"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (IS_IPHONE5) {
        self.bottomConstraint.constant = 175;
    } else if (IS_IPHONE4) {
        self.bottomConstraint.constant = 110;
        
    } else if (IS_IPHONE6) {
        self.bottomConstraint.constant = 250;
        
    } else if (IS_IPHONE6P) {
        self.bottomConstraint.constant = 280;
        
    }
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
    
    if (sr.status == 0) {

        NSArray *array = [sr.dic objectForKey:@"sysCodeList"];
        for (NSDictionary *dic in array) {
            CityInfoModel *model = [CityInfoModel initWithDic:dic];
            [self.addressArray addObject:model];
        }
        [AccountManager sharedInstance].addressArray = self.addressArray;
    } else {
        [HUDManager showWarningWithText:sr.msg];
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    //取消textField的第一响应者
    [textField resignFirstResponder];

    //根据用户搜索的类型跳不同的页面.并把查询的值传过去.
    if (self.searchType == SearchBySchool) {

        SchoolResultViewController *schoolVC = [[SchoolResultViewController alloc] init];
        schoolVC.searchKey = self.searchTextField.text;
        schoolVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:schoolVC animated:YES];
        
    } else if (self.searchType == SearchByOrganization) {
    
        [OrganizationListViewController showOrganizationListBySearchKey:self.searchTextField.text nav:self.navigationController];
        
    } else if (self.searchType == SearchByLocation) {
        if (textField.text.length == 0 || [[textField.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            [HUDManager showWarningWithText:@"请输入关键字"];
            return NO;
        }
        AddressListViewController *addressVC = [[AddressListViewController alloc] init];
        addressVC.searchKey = self.searchTextField.text;
        addressVC.currentCity = @"上海";//[AccountManager sharedInstance].locationName;
        addressVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    
    return YES;
}

#pragma mark - BMKLocationServiceDelegate
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [AccountManager sharedInstance].locationX = [NSString stringWithFormat:@"%@", @(userLocation.location.coordinate.latitude)];
    [AccountManager sharedInstance].locationY= [NSString stringWithFormat:@"%@", @(userLocation.location.coordinate.longitude)];
    [_locService stopUserLocationService];

}

#pragma mark - event response

- (IBAction)searchBySchoolAction:(id)sender {
    //改变查询类型searchType, 设置三个按钮的颜色
    self.searchType = SearchBySchool;
    [self.searchBySchoolBtn       setTitleColor:kNavigationColor forState:(UIControlStateNormal)];
    [self.searchByOrganizationBtn setTitleColor:kGrayColor       forState:(UIControlStateNormal)];
    [self.searchByLocationBtn     setTitleColor:kGrayColor       forState:(UIControlStateNormal)];
    self.searchTextField.placeholder = @"请输入学校名称";
}
- (IBAction)searchByOrganizationAction:(id)sender {
    //改变查询类型searchType, 设置三个按钮的颜色
    self.searchType = SearchByOrganization;
    [self.searchByOrganizationBtn setTitleColor:kNavigationColor forState:(UIControlStateNormal)];
    [self.searchBySchoolBtn       setTitleColor:kGrayColor       forState:(UIControlStateNormal)];
    [self.searchByLocationBtn     setTitleColor:kGrayColor       forState:(UIControlStateNormal)];
    self.searchTextField.placeholder = @"请输入晚托机构名称";
    
}
- (IBAction)searchByLocationAction:(id)sender {
    //改变查询类型searchType, 设置三个按钮的颜色
    self.searchType = SearchByLocation;
    [self.searchByLocationBtn     setTitleColor:kNavigationColor forState:(UIControlStateNormal)];
    [self.searchByOrganizationBtn setTitleColor:kGrayColor       forState:(UIControlStateNormal)];
    [self.searchBySchoolBtn       setTitleColor:kGrayColor       forState:(UIControlStateNormal)];
    self.searchTextField.placeholder = @"请输入搜索地址";

}

/**
 *  更改城市点击事件
 *
 *  @param sender btn
 */
- (IBAction)cityNameBtnAction:(id)sender {
    NSLog(@"hehhe");
}



#pragma mark - private methods
/**
 *  设置SearchTextField
 */
- (void)loadSearchTextField {
    self.searchGlassImageView.frame = CGRectMake(0, 2, 32, 28);
    self.searchTextField.leftView = self.searchGlassImageView;
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    self.searchTextField.layer.cornerRadius = 5;
    self.searchTextField.layer.masksToBounds = YES;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
}

- (void) starLocation {
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
