//
//  FollowSummaryController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FollowSummaryController.h"

@interface FollowSummaryController ()
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;//备注
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *xingweiStarts;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *studyStarts;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UIButton *uncompleteBtn;


@end

@implementation FollowSummaryController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.remarkTV.layer.borderWidth = 1.f;
    self.remarkTV.layer.borderColor = kBGColor.CGColor;
    self.remarkTV.layer.cornerRadius = 5.f;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"跟踪总结页面"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"跟踪总结页面"];
}

#pragma mark - 协议名
#pragma mark - event response
/**
 * 是否完成作业按钮
 */
- (IBAction)selectHomeWorkBtns:(UIButton *)sender {
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case 111://已完成作业
            self.uncompleteBtn.selected = NO;
            break;
            
        case 112://未完成作业
            self.completeBtn.selected = NO;
            break;
            

    }
}
/**
 * 行为评价
 */
- (IBAction)xingweiCommentAction:(UIButton *)sender {
    for (UIButton *btn in self.xingweiStarts) {
        [btn setImage:[UIImage imageNamed:@"organization_StarYellow"] forState:UIControlStateNormal];
        if (btn.tag > sender.tag) {
            [btn setImage:[UIImage imageNamed:@"organization_StarGray"] forState:UIControlStateNormal];
        }
    }

}
/**
 * 学习评价
 */
- (IBAction)studyCommentAction:(UIButton *)sender {
    for (UIButton *btn in self.studyStarts) {
        [btn setImage:[UIImage imageNamed:@"organization_StarYellow"] forState:UIControlStateNormal];
        if (btn.tag > sender.tag) {
            [btn setImage:[UIImage imageNamed:@"organization_StarGray"] forState:UIControlStateNormal];
        }
    }

}
/**
 * 总结按钮
 */
- (IBAction)sumupAction:(UIButton *)sender {
}
#pragma mark - private methods

@end
