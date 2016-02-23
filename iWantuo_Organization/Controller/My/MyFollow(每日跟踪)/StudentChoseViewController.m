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
#import "MCGrowCurveViewController.h"

@interface StudentChoseViewController ()<UITableViewDataSource,UITableViewDelegate,PageManagerDelegate,APIRequestDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;
@property (nonatomic, strong) ApiStudentByClassRequest *api;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
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
            //判断是否有数据
            if (self.dataArray.count > 0 ) {
                self.emptyImageView.hidden = YES;
            } else {
                self.emptyImageView.hidden = NO;
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
    cell.GCExpressionBtn.tag = 3000000 + indexPath.row;
    [cell.GCExpressionBtn addTarget:self action:@selector(expressionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.GCCurveBtn.tag = 3000000 + indexPath.row;
    [cell.GCCurveBtn addTarget:self action:@selector(curveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //取消textField的第一响应者
    [textField resignFirstResponder];
    
    //根据用户搜索的类型跳不同的页面.并把查询的值传过去.
    if (textField.text.length == 0 || [[textField.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入学生名称"];
        return NO;
    }
    
    //执行按名称查询
    [HUDManager showLoadingHUDView:self.view];
    self.api.requestCurrentPage = 1;
    
    [self.api setApiParamsWithClassId:self.classModel.classId name:textField.text page:[NSString stringWithFormat:@"%@", @(self.api.requestCurrentPage)]];
    [APIClient execute:self.api];    return YES;
}

#pragma mark - event response
/**
 * 每日表现（每日追踪）
 */
- (void)expressionBtnClick:(UIButton *)button {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(button.tag - 3000000) inSection:0];
    FollowBaseViewController *vc = [[FollowBaseViewController alloc]init];
    vc.student = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}
/**
 * 成长曲线
 */
- (void)curveBtnClick:(UIButton *)button {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(button.tag - 3000000) inSection:0];
    StudentModel *model = self.dataArray[indexPath.row];
    
    MCGrowCurveViewController *curveVC = [[MCGrowCurveViewController alloc] init];
    curveVC.studentId = model.studentId;
    [self.navigationController pushViewController:curveVC animated:YES];
}


#pragma mark - private methods
- (void)inistalSearch{
   // self.title = @"选择学生";
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
    tf.delegate = self;
    self.navigationItem.titleView =tf;
    
}

@end
