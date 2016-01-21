//
//  AddMyClassViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AddMyClassViewController.h"

@interface AddMyClassViewController ()
@property (weak, nonatomic) IBOutlet UITextField *classNameTF;

@end

@implementation AddMyClassViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加班级";
}
#pragma mark - 协议名
#pragma mark - event response
- (IBAction)addClassBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.classNameTF.text.length == 0) {
        [HUDManager showWarningWithText:@"请输入班级名称"];
        return;
    }
}


#pragma mark - private methods



@end
