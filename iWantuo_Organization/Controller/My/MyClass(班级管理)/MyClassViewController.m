//
//  MyClassViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyClassViewController.h"
#import "MyClassCell.h"

@interface MyClassViewController ()<UITableViewDataSource,UITableViewDelegate,MyClassCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MyClassViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"班级管理";
    //导航栏右侧按钮
    [self setRightBtnImage:[UIImage imageNamed:@"my_myclassadd"] eventHandler:^(id sender) {
        
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
    
    static NSString *classCell = @"myClassCell";
    MyClassCell *cell = [tableView dequeueReusableCellWithIdentifier:classCell];
    if (!cell) {
        cell = [MyClassCell shareMyClassCell];
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
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - myclassCelldelegate
-(void)myClassCellCliecDeleBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row{
    //点击cell 删除按钮
    NSLog(@"%ld",row);
    
}
#pragma mark - event response


#pragma mark - private methods

@end
