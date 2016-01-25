//
//  StudentChoseViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "StudentChoseViewController.h"
#import "StudentChoseCell.h"
#import "FollowSignInViewController.h"
#import "FollowBaseViewController.h"
#import "PageManager.h"
#import "ApiStudentByClassRequest.h"
#import "StudentModel.h"
#import "FollowSummaryController.h"

@interface StudentChoseViewController ()<UITableViewDataSource,UITableViewDelegate,PageManagerDelegate,APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;
@property (nonatomic, strong) ApiStudentByClassRequest *api;
@end

@implementation StudentChoseViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inistalSearch];
    
    self.dataArray = [NSMutableArray array];
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.api = [[ApiStudentByClassRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableview];
    [self.tableview.mj_header beginRefreshing];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"每日追踪选择学生"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"每日追踪选择学生"];
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
    if (api == self.api) {
        if (sr.status == 0) {
            if (api.requestCurrentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            api.requestCurrentPage ++;
            NSArray *array = [sr.dic objectForKey:@"StudentClassList"];
            for (NSDictionary *dic in array) {
                
                StudentModel *model = [StudentModel initWithDic:dic];
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
    
    [self.api setApiParamsWithClassId:self.classModel.classId name:@"" page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)]];
    [APIClient execute:self.api];
}
- (void)footerRereshing {
    
    [self.api setApiParamsWithClassId:self.classModel.classId name:@"" page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)]];
    [APIClient execute:self.api];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myTypeCell = @"StudentChoseCell";
    
    StudentChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:myTypeCell];
    if (!cell) {
        cell = [StudentChoseCell shareStudentChoseCell];
    }
    
    StudentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.name;
    return cell;
}

#pragma mark - UITableViewDelegate

/**
 *  设置cell高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellHeightText;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FollowBaseViewController *vc = [[FollowBaseViewController alloc]init];
    vc.student = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
//    FollowSummaryController *vc = [[FollowSummaryController alloc]init];
//    //vc.student = self.dataArray[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - event response
#pragma mark - private methods
- (void)inistalSearch{
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 30, 25)];
    iv.image = [UIImage imageNamed:@"home_glass"];
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    tf.placeholder = @"选择学生";
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
