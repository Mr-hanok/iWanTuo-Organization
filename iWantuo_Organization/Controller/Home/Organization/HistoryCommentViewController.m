//
//  HistoryCommentViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "HistoryCommentViewController.h"
#import "ApiCommentListRequest.h"
#import "CommentCell.h"
#define kCommentCell @"CommentCellReuse"
@interface HistoryCommentViewController ()<UITableViewDelegate, UITableViewDataSource, APIRequestDelegate, PageManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ApiCommentListRequest *api;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;

@end

@implementation HistoryCommentViewController
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
    self.title = @"历史评价";
    
    [self.tableView registerNib:[CommentCell nibWithCell] forCellReuseIdentifier:kCommentCell];
    self.api = [[ApiCommentListRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark - PageManagerDelegate
- (void)headerRefreshing {
    self.api.requestCurrentPage = 1;
    [self.api setApiParamesWithPage:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)] organizationAccounts:self.loginAccounts];
    [APIClient execute:self.api];
}
- (void)footerRereshing {
    [self.api setApiParamesWithPage:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)] organizationAccounts:self.loginAccounts];
    [APIClient execute:self.api];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CommentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    CommentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCommentCell];
    [cell configWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return [CommentCell cellHeightWithModel:model];
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
        if (self.api.requestCurrentPage == 1) {
            [self.dataArray removeAllObjects];
        }
        api.requestCurrentPage ++;
        NSArray *array = [sr.dic objectForKey:@"evaluateList"];
        for (NSDictionary *dic in array) {
            CommentModel *model = [CommentModel initWithDic:dic];
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
