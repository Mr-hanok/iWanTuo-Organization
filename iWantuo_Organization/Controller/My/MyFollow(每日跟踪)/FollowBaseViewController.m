//
//  FollowBaseViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FollowBaseViewController.h"
#import "FollowSignInViewController.h"
#import "FollowLeaveViewController.h"
#import "FollowSummaryController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface FollowBaseViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@property (weak, nonatomic) IBOutlet UIButton *sumaryBtn;
@property (weak, nonatomic) IBOutlet UIButton *leaveBtn;

@property (weak, nonatomic) IBOutlet UIButton *timeBtn;//时间按钮
@property (weak, nonatomic) IBOutlet UIImageView *followIV;//追踪进度图片

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollview;
@property (nonatomic, strong) FollowSignInViewController *signVC;//签到
@property (nonatomic, strong) FollowSummaryController *summaryVC;//总结
@property (nonatomic, strong) FollowLeaveViewController *leaveVC;//离校
@property (nonatomic, assign) BOOL isSelete;
@end

@implementation FollowBaseViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"每日追踪";
    self.signBtn.selected = YES;
    self.followIV.image = [UIImage imageNamed:@"followsignline"];
    [self.scrollview addSubview:self.signVC.view];
    [self.scrollview addSubview:self.summaryVC.view];
    [self.scrollview addSubview:self.leaveVC.view];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    [self.orderListVC.view setFrame:CGRectMake(0, 0, kScreenBoundWidth, kScreenBoundHeight - kNavigationHeight - kSelectBtnHeight)];
//    [self.recordListVC.view setFrame:CGRectMake(kScreenBoundWidth, 0, kScreenBoundWidth, kScreenBoundHeight - kNavigationHeight - kSelectBtnHeight)];
//    self.orderServerBtnWidth.constant = kScreenBoundWidth / 2.0 + 13;
//    
//    if (self.isShowRecord) {
//        [self.scrollView setContentOffset:CGPointMake(kScreenBoundWidth, 0) animated:NO];
//    }

    [self.signVC.view setFrame:CGRectMake(0, 0, kScreenBoundWidth, self.scrollview.frame.size.height)];
    
    [self.summaryVC.view setFrame:CGRectMake(kScreenBoundWidth, 0, kScreenBoundWidth, self.scrollview.frame.size.height)];
    
    [self.leaveVC.view setFrame:CGRectMake(kScreenBoundWidth*2, 0, kScreenBoundWidth, self.scrollview.frame.size.height)];
}

#pragma mark - 协议名

#pragma mark - event response
/**
 *  签到 总结 追踪按钮
 */
- (IBAction)followBtnsAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender) {
        
    }
    switch (sender.tag) {
        case 101://签到
        {
            self.sumaryBtn.selected = NO;
            self.leaveBtn.selected = NO;
            self.followIV.image = [UIImage imageNamed:@"followsignline"];
        }
            break;
            
        case 102://总结
        {
            self.signBtn.selected = NO;
            self.leaveBtn.selected = NO;
            self.followIV.image = [UIImage imageNamed:@"followsumupline"];
        }
            break;
            
        case 103://离校
        {
            self.sumaryBtn.selected = NO;
            self.signBtn.selected = NO;
            self.followIV.image = [UIImage imageNamed:@"followleaveline"];
        }
            break;
    
    }
    
    NSInteger a = sender.tag -101;
    [self.scrollview setContentOffset:CGPointMake(a*kScreenBoundWidth, 0) animated:YES];
    
}
/**
 *  时间按钮
 */
- (IBAction)followTimeBtnAction:(UIButton *)sender {
    
}
#pragma mark - private methods

#pragma mark - getters & setters
-(FollowSignInViewController *)signVC{
    if (_signVC == nil) {
        _signVC = [[FollowSignInViewController alloc]init];
    }
    return _signVC;
}
-(FollowSummaryController *)summaryVC{
    if (_summaryVC == nil) {
        _summaryVC = [[FollowSummaryController alloc]init];
    }
    return _summaryVC;
}
-(FollowLeaveViewController *)leaveVC{
    if (_leaveVC == nil) {
        _leaveVC = [[FollowLeaveViewController alloc]init];
    }
    return _leaveVC;
}


@end
