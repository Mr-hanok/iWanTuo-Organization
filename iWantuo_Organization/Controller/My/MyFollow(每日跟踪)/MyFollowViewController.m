//
//  MyFollowViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyFollowViewController.h"
#import "MyClassCell.h"
#import "StudentChoseViewController.h"
#import "ApiClassListRequest.h"
#import "PageManager.h"

@interface MyFollowViewController ()<UITableViewDelegate,UITableViewDataSource,APIRequestDelegate,PageManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) ApiClassListRequest *apiClassList;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *loginAccounts;


@end

@implementation MyFollowViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self inistalSearch];
    self.dataArray = [NSMutableArray array];
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.apiClassList = [[ApiClassListRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableview];
    [self.tableview.mj_header beginRefreshing];
    
    //判断是老师还是机构
    if ([[AccountManager sharedInstance].account.accountsType isEqualToString:@"3"]) {
        self.loginAccounts = [AccountManager sharedInstance].account.organizationAccounts;
        
    }else {
       self.loginAccounts = [AccountManager sharedInstance].account.loginAccounts;
    }


    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"我的跟踪选择班级"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"我的跟踪选择班级"];
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
    
    [self.apiClassList setApiParamsWithOrganizationAccounts:self.loginAccounts page:[NSString stringWithFormat:@"%@", @(self.apiClassList.requestCurrentPage)]];
    [APIClient execute:self.apiClassList];
}
- (void)footerRereshing {
    
    [self.apiClassList setApiParamsWithOrganizationAccounts:self.loginAccounts page:[NSString stringWithFormat:@"%@", @(self.apiClassList.requestCurrentPage)]];
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
    //公用班级管理班级cell
    ClassModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell configWithModel:model];
    cell.deleBtn.hidden = YES;
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
    
    StudentChoseViewController *vc = [[StudentChoseViewController alloc]init];
    vc.classModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - event response


#pragma mark - private methods
- (void)inistalSearch{
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 30, 25)];
    iv.image = [UIImage imageNamed:@"home_glass"];
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    tf.placeholder = @"班级";
    tf.leftView = iv;
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.layer.cornerRadius = 5;
    tf.layer.masksToBounds = YES;
    tf.layer.borderWidth = 1.f;
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    tf.layer.borderColor = kNavigationColor.CGColor;

    self.navigationItem.titleView =tf;
    
}


@end
