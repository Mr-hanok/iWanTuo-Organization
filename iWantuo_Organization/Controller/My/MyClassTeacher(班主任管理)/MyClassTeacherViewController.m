//
//  MyClassTeacherViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyClassTeacherViewController.h"
#import "MyClassTeacherCell.h"
#import "AddClassTeacherViewController.h"
#import "ApiTeacherListRequest.h"
#import "PageManager.h"
#import "TeacherModel.h"
#import "ApiDeleteTeacherRequest.h"

@interface MyClassTeacherViewController ()<MyClassTeacherCellDelegate, PageManagerDelegate, APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ApiTeacherListRequest *api;
@property (nonatomic, strong) ApiDeleteTeacherRequest *apiDelete;
@property (nonatomic, strong) PageManager *pageManager;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation MyClassTeacherViewController

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
    self.title = @"辅导老师管理";
    //导航栏右侧按钮 添加老师
    __weak typeof(self) weakSelf = self;
    [self setRightBtnImage:[UIImage imageNamed:@"my_myclassadd"] eventHandler:^(id sender) {
        AddClassTeacherViewController *vc = [[AddClassTeacherViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    
    self.api = [[ApiTeacherListRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableview];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.tableFooterView = [[UIView alloc] init];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myCell = @"MyClassTeacherCell";
    MyClassTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (!cell) {
        cell = [MyClassTeacherCell shareMyClassTeacherCell];
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    TeacherModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell configWithModel:model];
    return cell;

}

#pragma mark - UITableViewDelegate

/**
 *  设置cell高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - MyClassTeacherCellDelegate
-(void)myClassTeacherCellCliecDeleBtn:(UIButton *)btn withIndexPath:(NSIndexPath *)indexPath {
    [AlertViewManager showAlertViewMessage:@"是否删除辅导老师?" handlerBlock:^{
        self.indexPath = indexPath;
        TeacherModel *model = [self.dataArray objectAtIndex:indexPath.row];
        self.apiDelete = [[ApiDeleteTeacherRequest alloc] initWithDelegate:self];
        [self.apiDelete setApiParamsWithTeacherId:model.teacherId];
        [APIClient execute:self.apiDelete];
        [HUDManager showLoadingHUDView:self.tableview];
       
    }];
    
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
    
    if (api == self.apiDelete) {
        if (sr.status == 0) {
            [self.dataArray removeObjectAtIndex:self.indexPath.row];
            [self.tableview reloadData];
        }

    } else if (api == self.api) {
        if (sr.status == 0) {
            if (api.requestCurrentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            api.requestCurrentPage ++;
            NSArray *array = [sr.dic objectForKey:@"queryList"];
            for (NSDictionary *dic in array) {
                TeacherModel *model = [TeacherModel initWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self.tableview reloadData];
        } else {
            [HUDManager showWarningWithText:sr.msg];
        }
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
    
    self.api.requestCurrentPage = 1;
    [self.api setApiParamsWithLoginAccounts:[AccountManager sharedInstance].account.loginAccounts page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)]];
    [APIClient execute:self.api];
}
- (void)footerRereshing {
    
    [self.api setApiParamsWithLoginAccounts:[AccountManager sharedInstance].account.loginAccounts page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)]];
    [APIClient execute:self.api];
}


#pragma mark - event response


#pragma mark - private methods

@end
