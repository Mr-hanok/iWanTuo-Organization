//
//  MyPushMessageViewController.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyPushMessageViewController.h"
#import "ApiPushMessageRequest.h"

@interface MyPushMessageViewController ()<APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextView *messageTV;
@property (nonatomic, strong) ApiPushMessageRequest *api;

@end

@implementation MyPushMessageViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"推送消息";
    
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
    self.messageTV.layer.borderWidth = 1.f;
    self.messageTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}
#pragma mark - 协议名
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

    [HUDManager showWarningWithText:sr.msg];

}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {

    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}


#pragma mark - event response
/**
 * 发送按钮
 */
- (IBAction)sendBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.messageTV.text.length == 0 || [[self.messageTV.text stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请输入推送内容"];
        return;
    }
    self.api = [[ApiPushMessageRequest alloc] initWithDelegate:self];
    [self.api setApiParmsWithContent:self.messageTV.text];
    [APIClient execute:self.api];
    [HUDManager showLoadingHUDView:self.view];
}

#pragma mark - private methods

@end
