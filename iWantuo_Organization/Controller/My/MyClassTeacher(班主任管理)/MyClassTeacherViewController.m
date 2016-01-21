//
//  MyClassTeacherViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyClassTeacherViewController.h"
#import "MyClassTeacherCell.h"
#import "AddClassTeacherViewController.h"

@interface MyClassTeacherViewController ()<MyClassTeacherCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MyClassTeacherViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"辅导老师管理";
    //导航栏右侧按钮 添加老师
    __weak typeof(self) weakSelf = self;
    [self setRightBtnImage:[UIImage imageNamed:@"my_myclassadd"] eventHandler:^(id sender) {
        AddClassTeacherViewController *vc = [[AddClassTeacherViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myCell = @"MyClassTeacherCell";
    MyClassTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (!cell) {
        cell = [MyClassTeacherCell shareMyClassTeacherCell];
    }
    cell.delegate = self;
    cell.row = indexPath.row;
    return cell;

    
}

#pragma mark - UITableViewDelegate

/**
 *  设置cell高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - MyClassTeacherCellDelegate
-(void)myClassTeacherCellCliecDeleBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row{
    
}

#pragma mark - event response


#pragma mark - private methods

@end
