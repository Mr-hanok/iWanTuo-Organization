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

@interface MyFollowViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyFollowViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self inistalSearch];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"我的跟踪选择班级"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"我的跟踪选择班级"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *classCell = @"myClassCell";
    MyClassCell *cell = [tableView dequeueReusableCellWithIdentifier:classCell];
    if (!cell) {
        cell = [MyClassCell shareMyClassCell];
    }
    //公用班级管理班级cell
    cell.deleBtn.hidden = YES;
    cell.classNameLabel.text= @"爱晚托";//班级名称
    cell.studentCountLabel.text = @"100";//班级人数
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
