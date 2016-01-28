//
//  MyMessageViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyNewsTableViewCell.h"
#import "MyNewsDetailViewController.h"


#define  kSystemNewsCellID  @"kSystemNewsCellID"

@interface MyMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (nonatomic,strong)NSMutableArray *messageArray;

@end

@implementation MyMessageViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的消息";
    [self installSubViews];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSystemNewsCellID];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDLog(@"选中 －－ indexPath.row = %ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MyNewsDetailViewController *detailVC = [[MyNewsDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];

}
#pragma mark - event response
#pragma mark - private methods
- (void)installSubViews
{
    self.view.backgroundColor          = [UIColor whiteColor];
    self.messageArray               = [NSMutableArray array];
    [self.messageTableView registerNib:[MyNewsTableViewCell nibOfNewsCell] forCellReuseIdentifier:kSystemNewsCellID];
    self.messageTableView.rowHeight = 85;
}

@end
