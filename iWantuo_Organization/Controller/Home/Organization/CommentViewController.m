//
//  CommentViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "CommentViewController.h"
#import "ApiSubmitCommentRequest.h"

@interface CommentViewController ()<APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextView *commentTV;//评价textview
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *starBtnArray;//星星数组Btn
@property (nonatomic, copy) NSString *evaluate;
@property (nonatomic, strong) ApiSubmitCommentRequest *api;

@end

@implementation CommentViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评价";
    self.commentTV.frame = CGRectZero;
    self.evaluate = @"5";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self setDottedLineTextView:self.commentTV];
}
#pragma mark - 协议名
#pragma mark - event response
/**
 *  评价星星 
 */
- (IBAction)starBtnAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101://1颗星
            self.evaluate = @"1";
            break;
            
        case 102://2颗星
            self.evaluate = @"2";
            break;
            
        case 103://3颗星
            self.evaluate = @"3";
            break;
            
        case 104://4颗星
            self.evaluate = @"4";
            break;
            
        case 105://5颗星
            self.evaluate = @"5";
            break;


    }
    
    for (UIButton *btn in self.starBtnArray) {
        [btn setBackgroundImage:[UIImage imageNamed:@"organization_StarYellow"] forState:UIControlStateNormal];
        if (btn.tag > sender.tag) {
          [btn setBackgroundImage:[UIImage imageNamed:@"organization_StarGray"] forState:UIControlStateNormal];
        }        
    }
}
/**
 *  评价提交
 */
- (IBAction)commentBtnAtion:(UIButton *)sender {
    self.api = [[ApiSubmitCommentRequest alloc] initWithDelegate:self];
    [self.api setApiParamesWithEvaluatePerson:[AccountManager sharedInstance].account.loginAccounts evaluateDetails:self.commentTV.text evaluate:self.evaluate organizationAccounts:self.loginAccounts];
    [APIClient execute:self.api];
    [HUDManager showLoadingHUDView:self.view];
    
}
#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    
    [HUDManager hideHUDView];
    
    [AlertViewManager showAlertViewWithMessage:kDefaultNetWorkErrorString];
    
}

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {
    
    [HUDManager hideHUDView];
    
    if (sr.dic == nil || [sr.dic isKindOfClass:[NSNull class]]) {
        return;
    }
   
    if (sr.status == 0) {
        [HUDManager showWarningWithText:sr.msg];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [HUDManager showWarningWithText:sr.msg];
    }
  
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {
    
    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}

#pragma mark - private methods
/**
 *  设置虚线框
 */
- (void)setDottedLineTextView:(UITextView *)tv {
    //设置文本线框
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = kBGColor.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRoundedRect:tv.bounds cornerRadius:0].CGPath;
    border.lineWidth = 1.f;
    [tv.layer addSublayer:border];
}


@end
