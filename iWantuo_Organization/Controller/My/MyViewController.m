//
//  MyViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/6.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyViewController.h"
#import "MyCell.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "PersonDetailController.h"
#import "MyBookingViewController.h"
#import "MyFollowViewController.h"
#import "MyClassViewController.h"
#import "MyClassTeacherViewController.h"
#import "MyPushMessageViewController.h"
#import "MyStudentViewController.h"
#import "MyMessageViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@end

@implementation MyViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    __weak typeof(self) weakSelf = self;
    [self setRightBtnImage:[UIImage imageNamed:@"home_unSelect"] eventHandler:^(id sender) {
        SettingViewController *vc = [[SettingViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    self.logoutBtn.backgroundColor = kNavigationColor;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.hidesBottomBarWhenPushed = NO;
    [MobClick beginLogPageView:@"我的"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"我的"];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myCell = @"MyCell";
    static NSString *myTypeCell = @"MyTypeCell";
    
    MyCell *cell1 = [tableView dequeueReusableCellWithIdentifier:myCell];
    MyCell *cell2 = [tableView dequeueReusableCellWithIdentifier:myTypeCell];
    if (indexPath.row == 0) {
        if (!cell1) {
            cell1 = [MyCell shareMyCell];
        }
        
        return cell1;
    }else {
        if (!cell2) {
            cell2 = [MyCell shareMyTypeCell];
        }
        cell2.row = indexPath.row;
        
        return cell2;
    }
}

#pragma mark - UITableViewDelegate

/**
 *  设置cell高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }
    return kTableViewCellHeightText;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseViewController *vc = nil;
    switch (indexPath.row) {
        case 0://基本信息
            vc = [[PersonDetailController alloc]init];
            break;
        case 1://每日跟踪
            vc = [[MyFollowViewController alloc]init];
            break;
        case 2://学员管理
            vc = [[MyStudentViewController alloc]init];
            break;
        case 3://预约管理
            vc = [[MyBookingViewController alloc]init];
            break;
        case 4://我的消息
            vc = [[MyMessageViewController alloc]init];
            break;
        case 5://班级管理
            vc = [[MyClassViewController alloc]init];
            break;
        case 6://班主任管理
            vc = [[MyClassTeacherViewController alloc]init];
            break;
        case 7://推送消息
            vc = [[MyPushMessageViewController alloc]init];
            break;

    }
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - event response
/**
 *  退出按钮
 */
- (IBAction)Logout:(UIButton *)sender {
    
    kRootViewController = [[LoginViewController alloc]init];
}

#pragma mark - private methods


@end
