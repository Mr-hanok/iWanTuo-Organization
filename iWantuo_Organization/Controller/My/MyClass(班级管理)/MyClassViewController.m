//
//  MyClassViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyClassViewController.h"
#import "MyClassCell.h"
#import "AddMyClassViewController.h"
#import "ClassDetailViewController.h"
#import "ApiClassListRequest.h"
#import "PageManager.h"
#import "ApiDeleteClassRequest.h"
#import "ClassModel.h"

@interface MyClassViewController ()<UITableViewDataSource,UITableViewDelegate,MyClassCellDelegate, APIRequestDelegate, PageManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) ApiClassListRequest *apiClassList;
@property (nonatomic, strong) ApiDeleteClassRequest *apiDelete;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation MyClassViewController

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
    self.title = @"班级管理";
    //导航栏右侧按钮
    __weak typeof(self) weakself = self;
    [self setRightBtnImage:[UIImage imageNamed:@"my_myclassadd"] eventHandler:^(id sender) {
        AddMyClassViewController *vc = [[AddMyClassViewController alloc]init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.apiClassList = [[ApiClassListRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableview];
    [self.tableview.mj_header beginRefreshing];
  
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [HUDManager hideHUDView];
    
    [AlertViewManager showAlertViewWithMessage:kDefaultNetWorkErrorString];
    
}

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [HUDManager hideHUDView];
    
    if (sr.dic == nil || [sr.dic isKindOfClass:[NSNull class]]) {
        return;
    }
    if (api == self.apiClassList) {
        if (sr.status == 0) {
            if (api.requestCurrentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            api.requestCurrentPage ++;
            NSArray *array = [sr.dic objectForKey:@"classtList"];
            for (NSDictionary *dic in array) {
                ClassModel *model = [ClassModel initWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self.tableview reloadData];
        } else {
            [HUDManager showWarningWithText:sr.msg];
        }
    } else if (api == self.apiDelete) {
        if (sr.status == 0) {
//            [self.tableview deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationRight];
            [self.dataArray removeObjectAtIndex:self.indexPath.row];
            [self.tableview reloadData];
            
        }
        [HUDManager showWarningWithText:sr.msg];
    }
   
    
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}
#pragma mark - PageManagerDelegate
- (void)headerRefreshing {
    
    self.apiClassList.requestCurrentPage = 1;

    [self.apiClassList setApiParamsWithOrganizationAccounts:[AccountManager sharedInstance].account.loginAccounts page:[NSString stringWithFormat:@"%@", @(self.apiClassList.requestCurrentPage)]organizationClass:@""];
    [APIClient execute:self.apiClassList];
}
- (void)footerRereshing {
    
    
    [self.apiClassList setApiParamsWithOrganizationAccounts:[AccountManager sharedInstance].account.loginAccounts page:[NSString stringWithFormat:@"%@", @(self.apiClassList.requestCurrentPage)]organizationClass:@""];
    [APIClient execute:self.apiClassList];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *classCell = @"myClassCell";
    MyClassCell *cell = [tableView dequeueReusableCellWithIdentifier:classCell];
    if (!cell) {
        cell = [MyClassCell shareMyClassCell];
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    ClassModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell configWithModel:model];
    return cell;
    
}

#pragma mark - UITableViewDelegate

/**
 *  设置cell高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ClassModel *model = [self.dataArray objectAtIndex:indexPath.row];
    ClassDetailViewController *vc = [[ClassDetailViewController alloc]init];
    vc.classModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - myclassCelldelegate
-(void)myClassCellCliecDeleBtn:(UIButton *)btn withIndexPath:(NSIndexPath *)indexPath{
    //点击cell 删除按钮
    NSLog(@"%ld",indexPath.row);
    self.indexPath = indexPath;
    ClassModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.num.intValue > 0) {
        [AlertViewManager showAlertViewMessage:@"班级内还有学生, 是否删除?" handlerBlock:^{
            
//            ClassModel *model = [self.dataArray objectAtIndex:indexPath.row];
            self.apiDelete = [[ApiDeleteClassRequest alloc] initWithDelegate:self];
            [self.apiDelete setApiParamsWithClassId:model.classId];
            [APIClient execute:self.apiDelete];
            [HUDManager showLoadingHUDView:self.tableview];
        }];
    } else {
        self.apiDelete = [[ApiDeleteClassRequest alloc] initWithDelegate:self];
        [self.apiDelete setApiParamsWithClassId:model.classId];
        [APIClient execute:self.apiDelete];
        [HUDManager showLoadingHUDView:self.tableview];
    }
    
   
    
}
#pragma mark - event response


#pragma mark - private methods

@end
