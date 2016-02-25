//
//  AccountListViewController.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AccountListViewController.h"
#import "ApiPatriarchListRequest.h"
#import "PageManager.h"
#import "PatriarchModel.h"
#import "UserInfoCell.h"

#define kUserInfoCellReuse @"UserInfoCell"
@interface AccountListViewController ()<UITableViewDataSource, UITableViewDelegate, APIRequestDelegate, PageManagerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PageManager *pageManager;
@property (nonatomic, strong) ApiPatriarchListRequest *apiPatriarch;
@property (nonatomic, strong) NSString *searchKey;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;

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
    self.apiPatriarch = [[ApiPatriarchListRequest alloc] initWithDelegate:self];
    self.pageManager = [PageManager handlerWithDelegate:self TableView:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserInfoCell" bundle:nil] forCellReuseIdentifier:kUserInfoCellReuse];
    
    [self inistalSearch];
    self.title = @"家长账号列表";
    self.emptyImageView.hidden = YES;

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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UserInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kUserInfoCellReuse];
    PatriarchModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.nickName;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.%@", model.headPortrait]] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    cell.accountLabel.text = model.loginAccounts;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    PatriarchModel *model = [self.dataArray objectAtIndex:indexPath.row];
    self.backBlock(model);
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
        NSArray *array = [sr.dic objectForKey:@"patriarchList"];
        for (NSDictionary *dic in array) {
            PatriarchModel *model = [PatriarchModel initWithDic:dic];
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
    
    self.apiPatriarch.requestCurrentPage = 1;
    [self.apiPatriarch setApiParamsWithLoginAccounts:self.searchKey page:[NSString stringWithFormat:@"%@", @(self.apiPatriarch.requestCurrentPage)]];
    [APIClient execute:self.apiPatriarch];
}
- (void)footerRereshing {
    
    [self.apiPatriarch setApiParamsWithLoginAccounts:self.searchKey page:[NSString stringWithFormat:@"%@", @(self.apiPatriarch.requestCurrentPage)]];
    [APIClient execute:self.apiPatriarch];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.searchKey = textField.text;
    [self.tableView.mj_header beginRefreshing];
    return YES;
}

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
