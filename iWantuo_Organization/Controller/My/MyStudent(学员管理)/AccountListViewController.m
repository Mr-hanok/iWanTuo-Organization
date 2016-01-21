//
//  AccountListViewController.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AccountListViewController.h"
#import "APIRequest.h"
#import "PageManager.h"

@interface AccountListViewController ()<UITableViewDataSource, UITableViewDelegate, APIRequestDelegate, PageManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;

@end

@implementation AccountListViewController

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
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableView];
//    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"绑定家长账号"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"绑定家长账号"];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableTableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReusableTableViewCell];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.backBlock(@"13354285540");
    [self.navigationController popViewControllerAnimated:YES];
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
//        NSArray *array = [sr.dic objectForKey:@"schoolList"];
//        for (NSDictionary *dic in array) {
//            SchoolModel *model = [SchoolModel initWithDic:dic];
//            [self.dataArray addObject:model];
//        }
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
//    self.api.requestCurrentPage = 1;
//    [self.api setApiParamsWithLocation:[AccountManager sharedInstance].locationId schoolName:self.searchKey page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)] locationX:[AccountManager sharedInstance].locationX locationY:[AccountManager sharedInstance].locationY];
//    [APIClient execute:self.api];
}
- (void)footerRereshing {
//    [self.api setApiParamsWithLocation:[AccountManager sharedInstance].locationId schoolName:self.searchKey page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)] locationX:[AccountManager sharedInstance].locationX locationY:[AccountManager sharedInstance].locationY];
//    [APIClient execute:self.api];
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
