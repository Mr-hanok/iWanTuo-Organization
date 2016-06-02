//
//  SigningViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "SigningViewController.h"
#import "SubmitInfoViewController.h"

@interface SigningViewController ()
@property (weak, nonatomic) IBOutlet UITextView *signingTV;
@property (nonatomic,strong)UIButton *leftBtn;//返回按钮

@end

@implementation SigningViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线签约";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}
#pragma mark - 协议名
#pragma mark - event response
/**
 *  同意按钮
 */
- (IBAction)agreeBtnAction:(UIButton *)sender {
    SubmitInfoViewController *vc = [[SubmitInfoViewController alloc]init];
    vc.phoneNum = self.phoneNum;
    vc.passWord = self.passWord;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - private methods

@end
