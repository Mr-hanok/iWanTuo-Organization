//
//  ClassDetailViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "ClassDetailCell.h"
#import "ClassAddStudentController.h"
#import "ApiStudentByClassRequest.h"
#import "PageManager.h"
#import "ApiDeleteStudentsByClassRequest.h"
#import "StudentModel.h"

@interface ClassDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ClassDetailCellDelegate, APIRequestDelegate, PageManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;
@property (nonatomic, strong) ApiStudentByClassRequest *api;
@property (nonatomic, strong) ApiDeleteStudentsByClassRequest *apiDelete;
@property (nonatomic, strong) NSMutableArray *deleteArray;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
@end

@implementation ClassDetailViewController
#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
        self.deleteArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"班级详情";
    
    //导航栏右侧按钮
    __weak typeof(self) weakself = self;
    [self setRightBtnImage:nil eventHandler:^(id sender) {
        //添加学生
        ClassAddStudentController *vc = [[ClassAddStudentController alloc]init];
        vc.classId = weakself.classModel.classId;
        [weakself.navigationController pushViewController:vc animated:YES];
        
    } anddel:^(id sender) {
        //删除
        NSString *deleteStr;
        for (int i = 0; i < self.deleteArray.count; i++) {
            StudentModel *model = [weakself.deleteArray objectAtIndex:i];
            if (i == 0) {
                
                deleteStr = [NSString stringWithFormat:@"%@", model.studentId];
               
            } else {
                //最后一个不加逗号
                 deleteStr = [NSString stringWithFormat:@"%@,%@", deleteStr, model.studentId];
            }
        }
        weakself.apiDelete = [[ApiDeleteStudentsByClassRequest alloc] initWithDelegate:weakself];
        [weakself.apiDelete setApiParamsWithStudentIds:deleteStr classId:weakself.classModel.classId login:[AccountManager sharedInstance].account.loginAccounts];
        [APIClient execute:weakself.apiDelete];
        [HUDManager showLoadingHUDView:weakself.tableview];
    }];
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.api = [[ApiStudentByClassRequest alloc] initWithDelegate:self];
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
            //是否有数据
            if (self.dataArray.count > 0 ) {
                self.emptyImageView.hidden = YES;
            } else {
                self.emptyImageView.hidden = NO;
            }
            [self.tableview reloadData];
        } else {
            [HUDManager showWarningWithText:sr.msg];
        }
    } else if (api == self.apiDelete) {
        if (sr.status == 0) {
            
            [self.dataArray removeObjectsInArray:self.deleteArray];
            [self.deleteArray removeAllObjects];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 1:self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *classDetail = @"ClassDetailCell";
    static NSString *classCell = @"classCell";
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classCell];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"班级名称:%@", self.classModel.organizationClass];
        return cell;
    }
    
    ClassDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:classDetail];
    if (!cell) {
        cell = [ClassDetailCell shareMyCell];
    }
    cell.row = indexPath.row;
    cell.delegate = self;
    StudentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];
    return cell;
    
}

#pragma mark - UITableViewDelegate

/**
 *  设置cell高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kTableViewCellHeightText;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = kBGColor;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenBoundWidth, 28)];
        label.text = @"学生";
        label.textColor = [UIColor darkGrayColor];
        label.backgroundColor =kBGColor;
        [view1 addSubview:label];
        return view1;

    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0 :28;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark -ClassDetailCellDelegate
-(void)classDetailCellSeletBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row{
    StudentModel *model = [self.dataArray objectAtIndex:row];
    model.isDelete = !btn.selected;
    if ([self.deleteArray indexOfObject:model] < self.deleteArray.count) {
        [self.deleteArray removeObject:model];
    } else {
        [self.deleteArray addObject:model];
    }
    btn.selected = !btn.selected;
}

#pragma mark - event response
#pragma mark - private methods
/**
 *  重写导航栏右侧添加按钮
 *
 *  @param btnImage  可以返回两个按钮
 *  @param handler  添加和删除
 */
-(void)setRightBtnImage:(UIImage *)btnImage eventHandler:(void (^)(id sender))handler anddel:(void (^)(id sender))handler1{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, 30, 44);
    [btn setImage:[UIImage imageNamed:@"my_myclassadd"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    
    UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.exclusiveTouch = YES;
    btn1.frame = CGRectMake(0, 0, 30, 44);
    [btn1 setImage:[UIImage imageNamed:@"my_delete"] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor clearColor];
    

    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    [btn1 bk_addEventHandler:^(id sender) {
        handler1(btn1);
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    if (self.tabBarController == nil) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
        self.navigationItem.rightBarButtonItems = @[item1,item2];
    }
}


@end
