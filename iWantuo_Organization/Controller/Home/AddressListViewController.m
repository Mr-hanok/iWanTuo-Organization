//
//  AddressListViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AddressListViewController.h"
#import "OrganizationListViewController.h"

@interface AddressListViewController () <UITableViewDataSource, UITableViewDelegate, PageManagerDelegate, BMKMapViewDelegate, BMKPoiSearchDelegate>
{
    BMKPoiSearch* _poisearch;
    int curPage;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;

//百度检索属性
//@property (nonatomic, strong) BMKCitySearchOption *citySearchOption;
@end

@implementation AddressListViewController

#pragma mark - life cycle
- (instancetype)init {
    if (self) {
        curPage = 0;
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"地址列表";
    self.tableView.tableFooterView = [[UIView alloc] init];
    _poisearch = [[BMKPoiSearch alloc]init];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    [MobClick beginLogPageView:@"主页搜索地址页面"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _poisearch.delegate = nil; // 不用时，置nil
    [MobClick endLogPageView:@"主页搜索地址页面"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)dealloc {
    if (_poisearch != nil) {
        _poisearch = nil;
    }
}

- (void)searchAddress {
    BMKCitySearchOption *citySearchOption;
    citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= @"上海";//self.currentCity;
    citySearchOption.keyword = self.searchKey;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];

    if (flag) {
        NSLog(@"城市内检索发送成功");
    } else {
        NSLog(@"城市内检索发送失败");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (error == BMK_SEARCH_NO_ERROR) {
        if (curPage == 0) {
            [self.dataArray removeAllObjects];
        }
        curPage ++;
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            [self.dataArray addObject:poi];

        }
        [self.tableView reloadData];

    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
        
    } else if (error == BMK_SEARCH_RESULT_NOT_FOUND){
        NSLog(@"没有找到检索结果");
    } else if (error == BMK_SEARCH_NETWOKR_ERROR) {
        NSLog(@"网络连接错误");
    } else if (error == BMK_SEARCH_NETWOKR_TIMEOUT) {
        NSLog(@"网络连接超时");
    } else {
        NSLog(@"查询失败");
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableTableViewCellSubtitle];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kReusableTableViewCellSubtitle];
    }
    BMKPoiInfo* poi = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BMKPoiInfo* poi = [self.dataArray objectAtIndex:indexPath.row];
    [OrganizationListViewController showOrganizationListByAddressWithLocationX:[NSString stringWithFormat:@"%@", @(poi.pt.latitude)] locationY:[NSString stringWithFormat:@"%@", @(poi.pt.longitude)] nav:self.navigationController];
}

#pragma mark - PageManagerDelegate
- (void)headerRefreshing {
    [self searchAddress];
}
- (void)footerRereshing {
    [self searchAddress];
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
