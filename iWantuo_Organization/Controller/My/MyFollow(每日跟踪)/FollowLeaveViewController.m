//
//  FollowLeaveViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FollowLeaveViewController.h"

@interface FollowLeaveViewController ()

@property (weak, nonatomic) IBOutlet UITextView *remarkTV;//备注
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;//上传图片按钮
@end

@implementation FollowLeaveViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.remarkTV.layer.borderWidth = 1.f;
    self.remarkTV.layer.borderColor = kBGColor.CGColor;
    self.remarkTV.layer.cornerRadius = 5.f;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"每日追踪离校"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"每日追踪离校"];
}

#pragma mark - 协议名
#pragma mark - event response
/**
 *  上传图片按钮
 */
- (IBAction)upLoadBtnAction:(UIButton *)sender {
}
/**
 * 离校按钮
 */
- (IBAction)signBtnAction:(UIButton *)sender {
    
}
#pragma mark - private methods


@end
