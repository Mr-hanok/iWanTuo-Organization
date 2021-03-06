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

@interface ClassAddStudentController ()<UITableViewDataSource,UITableViewDelegate,ClassAddStudentCellDelegate, APIRequestDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ApiStudentByOrgRequest *api;
@property (nonatomic, strong) ApiSaveStudentsByClassRequest *apiSave;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
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
    [self setRightBtn:@"添加" eventHandler:^(id sender) {
        if (weakself.addArray.count == 0) {
            [HUDManager showWarningWithText:@"请选择学生"];
            return ;
        }
        NSString *addStr;
        for (int i = 0; i < self.addArray.count; i++) {
            StudentModel *model = [weakself.addArray objectAtIndex:i];
            if (i == 0) {
                
                addStr = [NSString stringWithFormat:@"%@", model.Id];
                
            } else {
                //最后一个不加逗号
                addStr = [NSString stringWithFormat:@"%@,%@", addStr, model.Id];
            }
        }
        weakself.apiSave = [[ApiSaveStudentsByClassRequest alloc] initWithDelegate:weakself];
        [weakself.apiSave setApiParamsWithStudentIds:addStr classId:weakself.classId login:[AccountManager sharedInstance].account.loginAccounts];
        [APIClient execute:weakself.apiSave];
        [HUDManager showLoadingHUDView:weakself.tableview];

    }];
    [self inistalSearch];
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.api = [[ApiStudentByOrgRequest alloc] initWithDelegate:self];
    [self.api setApiParamsWithOrganizationAccounts:[AccountManager sharedInstance].account.loginAccounts classId:self.classId name:@""];
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

            [self.dataArray removeAllObjects];
            NSArray *array = [sr.dic objectForKey:@"studentList"];
            for (NSDictionary *dic in array) {
                StudentModel *model = [StudentModel initWithDic:dic];
                model.isAdd = NO;
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
    } else if (api == self.apiSave) {
        if (sr.status == 0) {
            
            [self.dataArray removeObjectsInArray:self.addArray];
            
            //是否有数据
            if (self.dataArray.count > 0 ) {
                self.emptyImageView.hidden = YES;
            } else {
                self.emptyImageView.hidden = NO;
            }
            
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    //网络请求~~~
    self.api = [[ApiStudentByOrgRequest alloc] initWithDelegate:self];
    [self.api setApiParamsWithOrganizationAccounts:[AccountManager sharedInstance].account.loginAccounts classId:self.classId name:textField.text];
    [APIClient execute:self.api];
    [HUDManager showLoadingHUDView:self.view];

    return YES;
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
    StudentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    model.isAdd = !model.isAdd;
    
    if ([self.addArray indexOfObject:model] < self.addArray.count) {
        [self.addArray removeObject:model];
    } else {
        [self.addArray addObject:model];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
//    btn.selected = !btn.selected;
}

#pragma mark - event response

#pragma mark - private methods
- (void)inistalSearch{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:view.bounds];
    iv.image = [UIImage imageNamed:@"my_search"];
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(33, 0, 200, 30)];
    tf.delegate = self;
    [tf setBorderStyle:UITextBorderStyleNone];
    tf.returnKeyType = UIReturnKeySearch;
    [view addSubview:iv];
    [view addSubview:tf];
    
    self.navigationItem.titleView =view;

}



@end
