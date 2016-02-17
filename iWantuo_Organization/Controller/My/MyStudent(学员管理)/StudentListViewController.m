//
//  StudentListViewController.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/2/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "StudentListViewController.h"
#import "ApiStudentListRequest.h"
#import "StudentModel.h"
#import "MyStudentViewController.h"
#import "StudentCell.h"
#import "ApiDelStudentByOrgRequest.h"

#define kStudentCellReuse @"studentCellReuse"
@interface StudentListViewController ()<UITableViewDataSource, UITableViewDelegate, APIRequestDelegate, PageManagerDelegate, MyStudentCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ApiStudentListRequest *api;
@property (nonatomic, strong) PageManager *pageManager;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
@property (nonatomic, strong) ApiDelStudentByOrgRequest *apiDelete;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation StudentListViewController

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
    self.title = @"学员管理";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StudentCell" bundle:nil] forCellReuseIdentifier:kStudentCellReuse];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.api = [[ApiStudentListRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    
    self.emptyImageView.hidden = YES;
    __weak typeof(self) weakSelf = self;
    [self setRightBtnImage:[UIImage imageNamed:@"my_myclassadd"] eventHandler:^(id sender) {
        MyStudentViewController *addVC = [[MyStudentViewController alloc] init];
        addVC.infoType = AddInfoType;
        [weakSelf.navigationController pushViewController:addVC animated:YES];
    }];
}

#pragma mark - MyStudentCellDelegate
- (void)myStudentCellCliecDeleBtn:(UIButton *)btn withIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", @(indexPath.row));
     self.indexPath = indexPath;
    StudentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    self.apiDelete = [[ApiDelStudentByOrgRequest alloc] initWithDelegate:self];
    [self.apiDelete setApiParmsWithOrganizationAccounts:model.organizationAccounts studentId:model.studentId];
    [APIClient execute:self.apiDelete];
    [HUDManager showLoadingHUDView:self.tableView];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kStudentCellReuse];
    cell.delegate = self;
    cell.indexPath = indexPath;
    StudentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDLog(@"选中 －－ indexPath.row = %ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    StudentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    MyStudentViewController *updateVC = [[MyStudentViewController alloc] init];
    updateVC.studentId = model.studentId;
    updateVC.infoType = UpdateInfoType;
    [self.navigationController pushViewController:updateVC animated:YES];
}

#pragma mark - PageManagerDelegate
- (void)headerRefreshing {
    self.api.requestCurrentPage = 1;
    [self.api setApiParamsWithOrganizationAccounts:[AccountManager sharedInstance].account.loginAccounts name:@"" page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)]];
    [APIClient execute:self.api];
}
- (void)footerRereshing {
    [self.api setApiParamsWithOrganizationAccounts:[AccountManager sharedInstance].account.loginAccounts name:@"" page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)]];
    [APIClient execute:self.api];
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
    if (api == self.api) {
        if (sr.status == 0) {
            if (self.api.requestCurrentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            self.api.requestCurrentPage++;
            
            NSArray *array = [sr.dic objectForKey:@"studentSchoolList"];
            if (array.count == 0) {
                self.emptyImageView.hidden = NO;
                return;
            } else {
                self.emptyImageView.hidden = YES;
            }
            for (NSDictionary *dic in array) {
                StudentModel *model = [StudentModel initWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        } else {
            [HUDManager showWarningWithText:sr.msg];
        }
    } else if (api == self.apiDelete) {
        
        if (sr.status == 0) {
            [self.dataArray removeObjectAtIndex:self.indexPath.row];
            [self.tableView reloadData];
        } else {
            [HUDManager showWarningWithText:sr.msg];
        }
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
