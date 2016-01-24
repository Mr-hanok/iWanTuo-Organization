//
//  FollowSignInViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FollowSignInViewController.h"

@interface FollowSignInViewController ()

@property (weak, nonatomic) IBOutlet UITextView *remarkTV;//备注
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;//上传图片按钮

@property (weak, nonatomic) IBOutlet UIButton *signBtn;//签到按钮
@property (weak, nonatomic) IBOutlet UIButton *lossBtn;//缺勤按钮

@end

@implementation FollowSignInViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.remarkTV.layer.borderWidth = 1.f;
    self.remarkTV.layer.borderColor = kBGColor.CGColor;
    self.remarkTV.layer.cornerRadius = 5.f;
    self.signBtn.selected = YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"每日追踪签到"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"每日追踪签到"];
}

#pragma mark - 协议名
#pragma mark - event respons
/**
 *  签到缺勤按钮
*/
- (IBAction)singOroutBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender == self.signBtn) {
        self.lossBtn.selected = NO;
    }
    if (sender == self.lossBtn) {
        self.signBtn.selected = NO;
    }
}
/**
 *  上传图片按钮
 */
- (IBAction)upLoadBtnAction:(UIButton *)sender {
}
/**
 * 签到按钮
 */
- (IBAction)signBtnAction:(UIButton *)sender {
    
}
#pragma mark - private methods


@end
