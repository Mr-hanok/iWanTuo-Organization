//
//  MyMessageViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyNewsTableViewCell.h"
#import "MyNewsDetailViewController.h"
#import "ApiSystemMsgRequest.h"
#import "MsgModel.h"

#define  kSystemNewsCellID  @"kSystemNewsCellID"

@interface MyMessageViewController ()<UITableViewDataSource,UITableViewDelegate,  APIRequestDelegate, PageManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (nonatomic,strong)NSMutableArray *messageArray;

@property (nonatomic, strong) ApiSystemMsgRequest *api;
@property (nonatomic, strong) PageManager *pageManager;

@end

@implementation MyMessageViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的消息";
    [self installSubViews];

    self.api = [[ApiSystemMsgRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.messageTableView];
    [self.messageTableView.mj_header beginRefreshing];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSystemNewsCellID];
    MsgModel *model = [self.messageArray objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDLog(@"选中 －－ indexPath.row = %ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MsgModel *model = [self.messageArray objectAtIndex:indexPath.row];
    MyNewsDetailViewController *detailVC = [[MyNewsDetailViewController alloc]init];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];

}
#pragma mark - PageManagerDelegate
- (void)headerRefreshing {
    self.api.requestCurrentPage = 1;
    [self.api setApiParmsWithPage:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)]];
    [APIClient execute:self.api];
}
- (void)footerRereshing {
    [self.api setApiParmsWithPage:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)]];
    [APIClient execute:self.api];
}

#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    [self.messageTableView.mj_header endRefreshing];
    [self.messageTableView.mj_footer endRefreshing];
    [HUDManager hideHUDView];
    
    [AlertViewManager showAlertViewWithMessage:kDefaultNetWorkErrorString];
    
}

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {
    [self.messageTableView.mj_header endRefreshing];
    [self.messageTableView.mj_footer endRefreshing];
    [HUDManager hideHUDView];
    
    if (sr.dic == nil || [sr.dic isKindOfClass:[NSNull class]]) {
        return;
    }
    if (sr.status == 0) {
        if (self.api.requestCurrentPage == 1) {
            [self.messageArray removeAllObjects];
        }
        api.requestCurrentPage ++;
        NSArray *array = [sr.dic objectForKey:@"manageList"];
        for (NSDictionary *dic in array) {
            MsgModel *model = [MsgModel initWithDic:dic];
            [self.messageArray addObject:model];
        }
        [self.messageTableView reloadData];
        
    } else {
        [HUDManager showWarningWithText:sr.msg];
    }
    
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {
    [self.messageTableView.mj_header endRefreshing];
    [self.messageTableView.mj_footer endRefreshing];
    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}


#pragma mark - event response
#pragma mark - private methods
- (void)installSubViews
{
    self.view.backgroundColor          = [UIColor whiteColor];
    self.messageArray               = [NSMutableArray array];
    [self.messageTableView registerNib:[MyNewsTableViewCell nibOfNewsCell] forCellReuseIdentifier:kSystemNewsCellID];
    self.messageTableView.rowHeight = 85;
}

@end
