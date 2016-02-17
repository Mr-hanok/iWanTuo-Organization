//
//  OrganizationListViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "OrganizationListViewController.h"
#import "FSDropDownMenu.h"
#import "DropDownListView.h"
#import "ApiSearchOrganizationRequest.h"
#import "OrganizationDetailViewController.h"
#import "OrganizationCell.h"
#import "OrganizationModel.h"
#import "CityInfoModel.h"

#define kOrganizationCellReuse @"OrganizationCell"
@interface OrganizationListViewController ()<UITableViewDataSource, UITableViewDelegate, APIRequestDelegate, PageManagerDelegate, FSDropDownMenuDataSource,FSDropDownMenuDelegate, DropDownChooseDelegate,DropDownChooseDataSource>
{
    NSInteger _index;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *leftDownMenuBtn;
@property (weak, nonatomic) IBOutlet UIView *rightDownView;
@property (nonatomic, strong) FSDropDownMenu *leftDownMenu;
@property (nonatomic, strong) DropDownListView *rightDownMenu;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;
@property (nonatomic, strong) ApiSearchOrganizationRequest *api;

@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *areaArr;
@property (nonatomic, strong) NSMutableArray *currentAreaArr;
@property (nonatomic, strong) NSMutableArray *chooseArray;

@property (nonatomic, strong) NSString *sortType;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *area;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;

@end

@implementation OrganizationListViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.cityArr = [NSMutableArray array];
        self.areaArr = [NSMutableArray array];
        self.chooseArray = [NSMutableArray array];
        self.dataArray = [NSMutableArray array];
        self.sortType = @"1";
        _index = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"晚托班机构";
    [self.tableView registerNib:[OrganizationCell nibWithCell] forCellReuseIdentifier:kOrganizationCellReuse];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.api = [[ApiSearchOrganizationRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    self.hidesBottomBarWhenPushed = YES;
    
    [self initDownMenu];
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
}


#pragma mark event respond
- (IBAction)leftDownMenuAction:(id)sender {
    [self.rightDownMenu hideExtendedChooseView];
    FSDropDownMenu *menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
    [UIView animateWithDuration:0.2 animations:^{
        
    } completion:^(BOOL finished) {
        [menu menuTapped];
    }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrganizationModel *model = self.dataArray[indexPath.row];
    OrganizationCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrganizationCellReuse];
    if (self.originType == OriginSort || self.originType == OriginOrganization || self.sortType.integerValue == 2) {
        cell.distanceLabel.hidden = YES;
    } else {
        cell.distanceLabel.hidden = NO;
    }
    [cell configWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    OrganizationDetailViewController *organizationVC = [[OrganizationDetailViewController alloc] init];
    OrganizationModel *model = [self.dataArray objectAtIndex:indexPath.row];
    organizationVC.loginAccounts = model.loginAccounts;
    [self.navigationController pushViewController:organizationVC animated:YES];
    
}

#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [HUDManager hideHUDView];
    
    [AlertViewManager showAlertViewWithMessage:kDefaultNetWorkErrorString];
    
}

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [HUDManager hideHUDView];
    
    if (sr.dic == nil || [sr.dic isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if (sr.status == 0) {
        if (api.requestCurrentPage == 1) {
            [self.dataArray removeAllObjects];
        }
        api.requestCurrentPage ++;
        NSArray *array = [sr.dic objectForKey:@"organizationList"];
        //是否有数据
        if (array.count > 0 ) {
            self.emptyImageView.hidden = YES;
        } else {
            self.emptyImageView.hidden = NO;
        }

        for (NSDictionary *dic in array) {
            OrganizationModel *model = [OrganizationModel initWithDic:dic];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    } else {
        [HUDManager showWarningWithText:sr.msg];
    }
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}
#pragma mark - PageManagerDelegate
- (void)headerRefreshing {
    self.api.requestCurrentPage = 1;
    [self loadingOrganizationData];
}
- (void)footerRereshing {
    
    [self loadingOrganizationData];
}


#pragma mark - FSDropDown datasource & delegate

- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == menu.rightTableView) {
        return _cityArr.count;
    }else{
        return _currentAreaArr.count;
    }
}
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == menu.rightTableView) {
        
        return _cityArr[indexPath.row];
    }else{
        return _currentAreaArr[indexPath.row];
    }
}


- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == menu.rightTableView){
        _currentAreaArr = _areaArr[indexPath.row];
        _index = indexPath.row;
        [menu.leftTableView reloadData];
    }else {
        if (_index == 0) {
            NSString *strOrigin = _currentAreaArr[indexPath.row];
            //去掉米字
            self.distance = [strOrigin substringToIndex:strOrigin.length - 1];
            self.area = @"";

        } else if (_index == 1) {
//            self.area = _currentAreaArr[indexPath.row];
            for (CityInfoModel *model in [AccountManager sharedInstance].addressArray) {
                if ([model.name isEqualToString:_currentAreaArr[indexPath.row]]) {
                    self.area = model.cityId;
                    self.distance = @"";
                }
            }
        }
        [self.leftDownMenuBtn setTitle:_currentAreaArr[indexPath.row] forState:UIControlStateNormal];
        //调接口 刷新数据
//        self.api.requestCurrentPage = 1;
//        [self loadingOrganizationData];
        [self.tableView.mj_header beginRefreshing];
        [HUDManager showLoadingHUDView:KeyWindow];
    }
    
}

#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"section:%@ ,index:%@",@(section),@(index));
    if (index == 0 || index == 1) {
        self.sortType = @"1";
    } else if (index == 2) {
        self.sortType = @"2";
    }
    //调接口  刷新数据
//    self.api.requestCurrentPage = 1;
//    [self loadingOrganizationData];
    [self.tableView.mj_header beginRefreshing];
    [HUDManager showLoadingHUDView:KeyWindow];
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [self.chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry = self.chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return self.chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

#pragma mark - private methods
- (void)initDownMenu {
    
    [self.cityArr addObject:@"附近"];
    [self.cityArr addObject:@"上海"];//[AccountManager sharedInstance].locationName
    [self.areaArr addObject:@[@"1000米",@"2000米",@"5000米"]];
    
    NSMutableArray *array = [NSMutableArray array];
    for (CityInfoModel *model in [AccountManager sharedInstance].addressArray) {
        [array addObject:model.name];
    }
    if (array.count == 0) {
        [array addObject:@""];
    }
    [self.areaArr addObject:array];
    
    _currentAreaArr = _areaArr[0];
    
    self.leftDownMenu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 30) andHeight:kScreenBoundHeight - kNavigationHeight - 30 ];
    self.leftDownMenu.transformView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expandableImage"]];
    self.leftDownMenu.tag = 1001;
    self.leftDownMenu.dataSource = self;
    self.leftDownMenu.delegate = self;
    [self.view addSubview:self.leftDownMenu];
    
    self.chooseArray = [NSMutableArray arrayWithArray:@[
                                                        @[@"智能排序",@"离我最近",@"评分最高"]
                                                        
                                                        ]];
    
    self.rightDownMenu = [[DropDownListView alloc] initWithFrame:CGRectMake(kScreenBoundWidth / 2, 0, kScreenBoundWidth / 2, 30) dataSource:self delegate:self superView:self.view];
    self.rightDownMenu.mSuperView = self.view;
    
    
    [self.view addSubview:self.rightDownMenu];
    
}

- (void)loadingOrganizationData{
    if (self.originType == OriginAddress) {
        //地址搜索
        [self.api setApiParamsWithLocation:[AccountManager sharedInstance].locationId bairro:self.area organization:@"" page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)] locationX:self.locationX locationY:self.locationY distance:self.distance Type:self.sortType rows:kRequestDataRows];
        
    } else if (self.originType == OriginOrganization) {
        
        //机构搜索
        [self.api setApiParamsWithLocation:[AccountManager sharedInstance].locationId bairro:self.area organization:self.searchKey page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)] locationX:[AccountManager sharedInstance].locationX locationY:[AccountManager sharedInstance].locationY distance:self.distance Type:self.sortType rows:kRequestDataRows];
        
    } else if (self.originType == OriginSchool) {
        
        //学校搜索
        [self.api setApiParamsWithLocation:[AccountManager sharedInstance].locationId bairro:self.area organization:@"" page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)] locationX:self.locationX locationY:self.locationY distance:self.distance Type:self.sortType rows:kRequestDataRows];
        
    }
    [APIClient execute:self.api];
    
}


#pragma mark - public
+ (void)showOrganizationListBySchoolWithLocationX:(NSString *) locationX locationY:(NSString *)locationY nav:(UINavigationController *)nav {
    OrganizationListViewController *organizationVC = [[OrganizationListViewController alloc] init];
    organizationVC.originType = OriginSchool;
    organizationVC.locationX = locationX;
    organizationVC.locationY = locationY;
    [nav pushViewController:organizationVC animated:YES];
}

+ (void)showOrganizationListByAddressWithLocationX:(NSString *) locationX locationY:(NSString *)locationY nav:(UINavigationController *)nav {
    OrganizationListViewController *organizationVC = [[OrganizationListViewController alloc] init];
    organizationVC.originType = OriginAddress;
    organizationVC.locationX = locationX;
    organizationVC.locationY = locationY;
    [nav pushViewController:organizationVC animated:YES];
}

+ (void)showOrganizationListBySearchKey:(NSString *) searchKey nav:(UINavigationController *)nav {
    OrganizationListViewController *organizationVC = [[OrganizationListViewController alloc] init];
    organizationVC.originType = OriginOrganization;
    organizationVC.searchKey = searchKey;
    organizationVC.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:organizationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
