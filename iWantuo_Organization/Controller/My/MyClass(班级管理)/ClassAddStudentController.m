//
//  ClassAddStudentController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ClassAddStudentController.h"
#import "ClassAddStudentCell.h"
#import "ApiStudentByOrgRequest.h"
#import "ApiSaveStudentsByClassRequest.h"

@interface ClassAddStudentController ()<UITableViewDataSource,UITableViewDelegate,ClassAddStudentCellDelegate, APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ApiStudentByOrgRequest *api;
@property (nonatomic, strong) ApiSaveStudentsByClassRequest *apiSave;
@property (nonatomic, strong) NSMutableArray *addArray;
@end

@implementation ClassAddStudentController
#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
        self.addArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __weak typeof(self) weakself = self;
    [self setRightBtn:@"确定" eventHandler:^(id sender) {
        NSString *addStr;
        for (int i = 0; i < self.addArray.count; i++) {
            StudentModel *model = [weakself.addArray objectAtIndex:i];
            if (i == 0) {
                
                addStr = [NSString stringWithFormat:@"%@", model.studentId];
                
            } else {
                //最后一个不加逗号
                addStr = [NSString stringWithFormat:@"%@,%@", addStr, model.studentId];
            }
        }
        weakself.apiSave = [[ApiSaveStudentsByClassRequest alloc] initWithDelegate:weakself];
        [weakself.apiSave setApiParamsWithStudentIds:addStr classId:weakself.classId];
        [APIClient execute:weakself.apiSave];
        [HUDManager showLoadingHUDView:weakself.tableview];

    }];
    [self inistalSearch];
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.api = [[ApiStudentByOrgRequest alloc] initWithDelegate:self];
    [self.api setApiParamsWithOrganizationAccounts:[AccountManager sharedInstance].account.loginAccounts classId:self.classId ];
    [APIClient execute:self.api];
    [HUDManager showLoadingHUDView:self.view];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"添加学生进班级"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"添加学生进班级"];
}

#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {

    [HUDManager hideHUDView];
    
    [AlertViewManager showAlertViewWithMessage:kDefaultNetWorkErrorString];
    
}

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {

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
            NSArray *array = [sr.dic objectForKey:@"studentList"];
            for (NSDictionary *dic in array) {
                StudentModel *model = [StudentModel initWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self.tableview reloadData];
        } else {
            [HUDManager showWarningWithText:sr.msg];
        }
    } else if (api == self.apiSave) {
        if (sr.status == 0) {
            
            [self.dataArray removeObjectsInArray:self.addArray];
            
            [self.addArray removeAllObjects];
            [self.tableview reloadData];
            
        }
        [HUDManager showWarningWithText:sr.msg];
    }
    
    
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {

    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}


#pragma mark - ClassAddStudentCellDelegate
-(void)classAddStudentCellSeletBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row{
    
    StudentModel *model = [self.dataArray objectAtIndex:row];
    model.isAdd = !btn.selected;
    if ([self.addArray indexOfObject:model] < self.addArray.count) {
        [self.addArray removeObject:model];
    } else {
        [self.addArray addObject:model];
    }
    btn.selected = !btn.selected;
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *addStudentCell = @"ClassAddStudentCell";
    
    ClassAddStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:addStudentCell];
    if (!cell) {
        cell = [ClassAddStudentCell shareMyCell];
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
    
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - event response

#pragma mark - private methods
- (void)inistalSearch{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:view.bounds];
    iv.image = [UIImage imageNamed:@"my_search"];
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(27, 0, 200, 30)];
    [tf setBorderStyle:UITextBorderStyleNone];
    [view addSubview:iv];
    [view addSubview:tf];
    
    self.navigationItem.titleView =view;

}



@end
