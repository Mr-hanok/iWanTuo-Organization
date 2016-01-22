//
//  ClassAddStudentController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ClassAddStudentController.h"
#import "ClassAddStudentCell.h"

@interface ClassAddStudentController ()<UITableViewDataSource,UITableViewDelegate,ClassAddStudentCellDelegate>

@end

@implementation ClassAddStudentController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setRightBtn:@"确定" eventHandler:^(id sender) {
        
    }];
    [self inistalSearch];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"添加学生进班级"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"添加学生进班级"];
}
#pragma mark - ClassAddStudentCellDelegate
-(void)classAddStudentCellSeletBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row{
    btn.selected = !btn.selected;
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *addStudentCell = @"ClassAddStudentCell";
    
    ClassAddStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:addStudentCell];
    if (!cell) {
        cell = [ClassAddStudentCell shareMyCell];
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
    
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
