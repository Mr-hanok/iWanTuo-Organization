//
//  DisListViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/26.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "DisListViewController.h"
#import "OrganizationDetailViewController.h"
#import "OrganizationCell.h"
#import "OrganizationModel.h"
#define kOrganizationCellReuse @"OrganizationCell"

@interface DisListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DisListViewController
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
    self.title = @"晚托机构";
    [self.tableView registerNib:[OrganizationCell nibWithCell] forCellReuseIdentifier:kOrganizationCellReuse];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"发现列表页面"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"发现列表页面"];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrganizationModel *model = self.dataArray[indexPath.row];
    OrganizationCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrganizationCellReuse];
    [cell configWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    OrganizationDetailViewController *organizationVC = [[OrganizationDetailViewController alloc] init];
    OrganizationModel *model = [self.dataArray objectAtIndex:indexPath.row];
    organizationVC.loginAccounts = model.loginAccounts;
    [self.navigationController pushViewController:organizationVC animated:YES];
    
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
