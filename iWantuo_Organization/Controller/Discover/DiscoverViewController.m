//
//  DiscoverViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/6.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DisSearchViewController.h"
#import "DisListViewController.h"
#import "ApiSearchOrganizationRequest.h"
#import "OrganizationModel.h"
#import "OrganizationDetailViewController.h"

@interface DiscoverViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, APIRequestDelegate>
{
    BMKLocationService *_locService;
    BMKCircle* circle;
}

@property (nonatomic, strong) BMKMapView* mapView;
@property (strong, nonatomic) IBOutlet UIView *cityNameView;
@property (weak  , nonatomic) IBOutlet UIButton *cityNameBtn;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ApiSearchOrganizationRequest *api;
@property(assign, nonatomic) CLLocationCoordinate2D coordinate;


@end

@implementation DiscoverViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self.mapView setZoomLevel:13.8];
    [self.mapView setMapType:BMKMapTypeStandard]; //设置地图模式:标准, 卫星
    self.view = self.mapView;
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    [self loadTopView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此v记得不用的时候需要置nil，否则影响内存的释放
    [MobClick beginLogPageView:@"发现页面"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    [MobClick endLogPageView:@"发现页面"];
}



#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
        newAnnotationView.animatesDrop = NO;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor alloc] initWithRed:0.5 green:0.5 blue:1 alpha:0.5];
        circleView.strokeColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0.3];
        circleView.lineWidth = 1.0;
        
        return circleView;
    }
    return nil;
}
/**
 *  点击标注触发的方法
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    NSLog(@"paopaoclick___tag:%@",@(view.tag));
//    if (view.tag == 0) {
//        return;
//    }
//    if ([view isKindOfClass:[BMKAnnotationView class]]){
//        OrganizationDetailViewController *detailVC = [[OrganizationDetailViewController alloc] init];
//        detailVC.loginAccounts = [NSString stringWithFormat:@"%@", @(view.tag)];
//        [self.navigationController pushViewController:detailVC animated:YES];
//    }
    
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
    if (view.tag == 0) {
        return;
    }
    if ([view isKindOfClass:[BMKAnnotationView class]]){
        OrganizationDetailViewController *detailVC = [[OrganizationDetailViewController alloc] init];
        detailVC.loginAccounts = [NSString stringWithFormat:@"%@", @(view.tag)];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        return;
    }
}

#pragma mark - BMKLocationServiceDelegate
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //更新地图显示
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
    //给属性复制
    self.coordinate = userLocation.location.coordinate;
    
    //停止获取定位
    [_locService stopUserLocationService];
    //请求数据
    [self requestData];
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
        [self.dataArray removeAllObjects];

        NSArray *array = [sr.dic objectForKey:@"organizationList"];
        for (NSDictionary *dic in array) {
            OrganizationModel *model = [OrganizationModel initWithDic:dic];
            [self.dataArray addObject:model];
            BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = model.coordinateX.doubleValue;
            coor.longitude = model.coordinateY.doubleValue;
            pointAnnotation.coordinate = coor;
            pointAnnotation.title = model.organization;
            [_mapView addAnnotation:pointAnnotation];
            BMKAnnotationView* aview = [_mapView viewForAnnotation:pointAnnotation];
            aview.tag = model.loginAccounts.integerValue;
        }
        
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

#pragma mark - private  methods
//添加内置覆盖物
- (void)addOverlayViewWithLatitude:(double)latitude longitude:(double)longitude{
    // 添加圆形覆盖物
    CLLocationCoordinate2D coor;
    coor.latitude = latitude;
    coor.longitude = longitude;
    circle = [BMKCircle circleWithCenterCoordinate:coor radius:5000];
    [self.mapView addOverlay:circle];
}

- (void)loadTopView {
    self.cityNameView.frame = CGRectMake(0, 0, 50, 32);
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:self.cityNameView];
    [self.cityNameBtn setTitle:@"上海" forState:(UIControlStateNormal)];
    
    UIButton *locationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [locationBtn setImage:[UIImage imageNamed:@"discover_locationY"] forState:(UIControlStateNormal)];
    [locationBtn addTarget:self action:@selector(locationBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    locationBtn.frame = CGRectMake(0, 0, 30, 30);
    
    UIButton *listBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [listBtn setImage:[UIImage imageNamed:@"discover_List"] forState:(UIControlStateNormal)];
    [listBtn addTarget:self action:@selector(listBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    listBtn.frame = CGRectMake(0, 0, 30, 30);
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:listBtn], [[UIBarButtonItem alloc]initWithCustomView:locationBtn]];
    
    UIButton *searchBtn  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [searchBtn setImage:[UIImage imageNamed:@"discover_Search"] forState:(UIControlStateNormal)];
    [searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    searchBtn.frame = CGRectMake(0, 0, 120, 30);
    self.navigationItem.titleView = searchBtn;
    
   
}

- (void)searchBtnAction:(UIButton *)btn {
    void(^backBlock)(CLLocationCoordinate2D coordinate, NSString *address) = ^(CLLocationCoordinate2D coordinate, NSString *address){
        
        self.coordinate = coordinate;
        [self requestData];
        //添加个红色的小圆点
        BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
        pointAnnotation.coordinate = coordinate;
        pointAnnotation.title = address;
        [_mapView addAnnotation:pointAnnotation];
        BMKAnnotationView* aview = [_mapView viewForAnnotation:pointAnnotation];
        aview.tag = 0;
//        [HUDManager showLoadingHUDView:self.view];
        
    };
    DisSearchViewController *searchVC = [[DisSearchViewController alloc] init];
    searchVC.backBlock = backBlock;
    searchVC.currentCity = @"上海";//[AccountManager sharedInstance].locationName;
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}


- (void)locationBtnAction:(UIButton *)btn {
    //启动LocationService
    [_locService startUserLocationService];
    [self requestData1];
//    [HUDManager showLoadingHUDView:self.view];
    
}

- (void)listBtnAction:(UIButton *)btn {
    DisListViewController *listVC = [[DisListViewController alloc] init];
    listVC.hidesBottomBarWhenPushed = YES;
    listVC.dataArray = self.dataArray;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)requestData {
    //清除之前的图层
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeAnnotations:_mapView.annotations];
    //画图层
    [self addOverlayViewWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    //设置地图中心
    [self.mapView setCenterCoordinate:self.coordinate animated:YES];
    
    //请求数据
    self.api = [[ApiSearchOrganizationRequest alloc] initWithDelegate:self];
    [self.api setApiParamsWithLocation:[AccountManager sharedInstance].locationId bairro:@"" organization:@"" page:@"1" locationX:[NSString stringWithFormat:@"%@", @(self.coordinate.latitude)] locationY:[NSString stringWithFormat:@"%@", @(self.coordinate.longitude)] distance:@"5000" Type:@"1" rows:@"1000"];

    [APIClient execute:self.api];
    [HUDManager showLoadingHUDView:self.view];
    
}
- (void)requestData1 {
    //清除之前的图层
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeAnnotations:_mapView.annotations];
    //画图层
    [self addOverlayViewWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    //设置地图中心
    [self.mapView setCenterCoordinate:self.coordinate animated:YES];
    
    //请求数据
    self.api = [[ApiSearchOrganizationRequest alloc] initWithDelegate:self];
    [self.api setApiParamsWithLocation:[AccountManager sharedInstance].locationId bairro:@"" organization:@"" page:@"1" locationX:[NSString stringWithFormat:@"%@", @(self.coordinate.latitude)] locationY:[NSString stringWithFormat:@"%@", @(self.coordinate.longitude)] distance:@"5000" Type:@"1" rows:@"1000"];
    
    [APIClient execute:self.api];
//    [HUDManager showLoadingHUDView:self.view];
    
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
