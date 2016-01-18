//
//  ForgetViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic,strong)UIButton *leftBtn;//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;//提交
@property (weak, nonatomic) IBOutlet UITextField *registerNumTF;//验证码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//电话号
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;//密码
@end

@implementation ForgetViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBg"] forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"忘记密码";
    [self.navigationController.navigationBar setBarStyle:(UIBarStyleBlack)];
    [self.navigationController.navigationBar setTintColor:kNavigationColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    //设置标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kNavigationColor};
    
    self.leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    [self.leftBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.leftBtn setTitleColor:kNavigationColor forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    //设置验证码按钮
    [self.registerBtn setTitleColor:kNavigationColor forState:UIControlStateNormal];
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

- (void)backItemAction{//返回按钮
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  提交按钮
 */
- (IBAction)commitAction:(UIButton *)sender {
    
    
}
/**
 *  验证码按钮
 */
- (IBAction)registerAction:(UIButton *)sender {
    
}
#pragma mark - private methods


@end
