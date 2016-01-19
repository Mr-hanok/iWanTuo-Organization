//
//  SubmitInfoViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "SubmitInfoViewController.h"

@interface SubmitInfoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *workRoomBtn;/**工作室*/
@property (weak, nonatomic) IBOutlet UIButton *companyBtn;/**公司*/
@property (weak, nonatomic) IBOutlet UITextField *shortNameTF;/**简称*/
@property (weak, nonatomic) IBOutlet UITextField *FullNameTF;/**全称*/
@property (weak, nonatomic) IBOutlet UITextField *trueNameTF;/**真实姓名*/
@property (weak, nonatomic) IBOutlet UITextField *detialAdressTF;/**详细地址*/
@property (weak, nonatomic) IBOutlet UITextField *emailTF;/**邮箱*/
@property (weak, nonatomic) IBOutlet UIButton *cardIdBtn;/**身份证*/
@property (weak, nonatomic) IBOutlet UIButton *licenseBtn;/**执照*/
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;/**图片*/
@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;/**添加图片按钮*/

@end

@implementation SubmitInfoViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提交资料";
    self.workRoomBtn.selected = YES;
    self.cardIdBtn.selected = YES;

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
 *  机构类型按钮
 */
- (IBAction)organizationTypeBtns:(UIButton *)sender {
    sender.selected = YES;
    switch (sender.tag) {
        case 101://工作室
            self.companyBtn.selected = NO;
            break;
            
        case 102://公司
            self.workRoomBtn.selected = NO;
            break;
    }
}
/**
 *  证件按钮
 */
- (IBAction)certificateBtns:(UIButton *)sender {
    sender.selected = YES;
    switch (sender.tag) {
        case 103://身份证
            self.licenseBtn.selected = NO;
            break;
            
        case 104://营业执照
            self.cardIdBtn.selected = NO;
            break;
    }

}
/**
 *  上传图片按钮
 */
- (IBAction)upLoadImageBtn:(UIButton *)sender {
}
/**
 *  提交按钮
 */
- (IBAction)commitBtn:(UIButton *)sender {
}

#pragma mark - private methods


@end
