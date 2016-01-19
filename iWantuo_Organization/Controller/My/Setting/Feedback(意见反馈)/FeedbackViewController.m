//
//  FeedbackViewController.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/15.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *connectTF;//联系方式
@property (weak, nonatomic) IBOutlet UITextView *suggestionTView;//意见
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

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
    self.connectTF.frame = CGRectZero;
    self.suggestionTView.frame = CGRectZero;

    [self setRightBtn:@"发送" eventHandler:^(id sender) {
        
    }];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self  setDottedLineTextView:self.suggestionTView andTextFiled:self.connectTF];

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
    border.strokeColor = kBGColor.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRoundedRect:tv.bounds cornerRadius:0].CGPath;
    border.lineWidth = 1.f;
    [tv.layer addSublayer:border];
    
    tf.borderStyle=UITextBorderStyleNone;
    tf.layer.borderColor = kBGColor.CGColor;
    tf.layer.borderWidth = 1.f;
}

@end
