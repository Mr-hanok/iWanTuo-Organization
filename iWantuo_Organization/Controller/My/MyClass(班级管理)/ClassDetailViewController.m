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

@interface ClassDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ClassDetailCellDelegate>

@end

@implementation ClassDetailViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"班级详情";
    
    //导航栏右侧按钮
    __weak typeof(self) weakself = self;
    [self setRightBtnImage:nil eventHandler:^(id sender) {
        //添加学生
        ClassAddStudentController *vc = [[ClassAddStudentController alloc]init];
        [weakself.navigationController pushViewController:vc animated:YES];
        
    } anddel:^(id sender) {
        //删除
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 1:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *classDetail = @"ClassDetailCell";
    static NSString *classCell = @"classCell";
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classCell];
        }
        cell.textLabel.text = @"班级名称:123";
        return cell;
    }
    
    ClassDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:classDetail];
    if (!cell) {
        cell = [ClassDetailCell shareMyCell];
    }
    cell.row = indexPath.row;
    cell.delegate = self;
    
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
    
}
#pragma mark -ClassDetailCellDelegate
-(void)classDetailCellSeletBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row{
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
