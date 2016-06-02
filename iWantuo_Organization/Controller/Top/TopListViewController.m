//
//  TopListViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "TopListViewController.h"
#import "ApiSearchOrganizationRequest.h"
#import "OrganizationDetailViewController.h"
#import "OrganizationCell.h"
#import "OrganizationModel.h"
#define kOrganizationCellReuse @"OrganizationCell"
@interface TopListViewController ()<UITableViewDataSource, UITableViewDelegate, APIRequestDelegate, PageManagerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;
@property (nonatomic, strong) ApiSearchOrganizationRequest *api;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;

@end

@implementation TopListViewController
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
    self.title = @"爱晚托推荐榜";
    [self.tableView registerNib:[OrganizationCell nibWithCell] forCellReuseIdentifier:kOrganizationCellReuse];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.api = [[ApiSearchOrganizationRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"排行榜"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"排行榜"];
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrganizationModel *model = self.dataArray[indexPath.row];
    OrganizationCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrganizationCellReuse];
    cell.distanceLabel.hidden = YES;
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
        
        for (NSDictionary *dic in array) {
            OrganizationModel *model = [OrganizationModel initWithDic:dic];
            [self.dataArray addObject:model];
        }
        //是否有数据
        if (self.dataArray.count > 0 ) {
            self.emptyImageView.hidden = YES;
        } else {
            self.emptyImageView.hidden = NO;
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

#pragma mark - private methods
- (void)loadingOrganizationData{

    [self.api setApiParamsWithLocation:[AccountManager sharedInstance].locationId bairro:@"" organization:@"" page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)] locationX:@"0.0" locationY:@"0.0" distance:@"" Type:@"3" rows:kRequestDataRows];

    [APIClient execute:self.api];
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
