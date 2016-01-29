//
//  FeedbackViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedBackRequest.h"

@interface FeedbackViewController ()<UITextViewDelegate,APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextField *connectTF;//联系方式
@property (weak, nonatomic) IBOutlet UITextView *suggestionTView;//意见
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

@property (nonatomic,strong)FeedBackRequest *feedbackApi;//

@end

@implementation FeedbackViewController

#pragma mark - life cycle
-(instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
   
    [self installSubViewsAndAction];

   
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
    [self  setDottedLineTextView:self.suggestionTView andTextFiled:self.connectTF];

}
#pragma mark -
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error
{
    [HUDManager hideHUDView];
    [HUDManager showWarningWithText:kDefaultNetWorkErrorString];
}
- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr
{
    [HUDManager hideHUDView];
    [AlertViewManager showAlertViewSuccessedMessage:@"意见反馈成功" handlerBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr
{
    [HUDManager hideHUDView];
    [AlertViewManager showAlertViewWithMessage:sr.msg];
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeHolderLabel.hidden = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    self.placeHolderLabel.hidden = textView.text.length>0?YES:NO;
}

#pragma mark - private methods
/**
 *  设置虚线框
 */
- (void)setDottedLineTextView:(UITextView *)tv andTextFiled:(UITextField *)tf{
    //设置文本线框
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor   = kBGColor.CGColor;
    border.fillColor     = nil;
    border.path          = [UIBezierPath bezierPathWithRoundedRect:tv.bounds cornerRadius:0].CGPath;
    border.lineWidth     = 1.f;
    [tv.layer addSublayer:border];
    tf.borderStyle       = UITextBorderStyleNone;
    tf.layer.borderColor = kBGColor.CGColor;
    tf.layer.borderWidth = 1.f;
}
- (void)installSubViewsAndAction
{
    self.connectTF.frame = CGRectZero;
    self.suggestionTView.frame = CGRectZero;
    self.feedbackApi = [[FeedBackRequest alloc]initWithDelegate:self];
    __weak FeedbackViewController *weakSelf = self;
    [self setRightBtn:@"发送" eventHandler:^(id sender) {
        [weakSelf sendFeedback];
        
    }];
}

- (void)sendFeedback
{
    if (self.suggestionTView.text.length <= 0) {
        [HUDManager showWarningWithText:@"请填写您的建议"];
        return;
    }
    [self.feedbackApi setApiParmsWithDic:@{@"feedbackDetails":self.suggestionTView.text}];
    [APIClient execute:self.feedbackApi];
    [HUDManager showLoadingHUDView:self.view withText:@"发送中..."];
    
}

@end
