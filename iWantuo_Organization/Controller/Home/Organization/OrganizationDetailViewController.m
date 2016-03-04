//
//  OrganizationDetailViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "OrganizationDetailViewController.h"
#import "CommentViewController.h"
#import "ApiOrganizationDetailRequest.h"
#import "SharSdkManager.h"
#import "ApiAddBookRequest.h"
#import "CancelAttentionHandler.h" 
#import "AttentionHandler.h"
#import "SystemHandler.h"
#import "HistoryCommentViewController.h"
#import "LoginViewController.h"
#import "ImageZoomTap.h"

@interface OrganizationDetailViewController ()<APIRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextView *organizationDetailTV;//机构介绍
@property (weak, nonatomic) IBOutlet UILabel *organizationNameLabel;//机构名称
@property (weak, nonatomic) IBOutlet UIImageView *organizationIV3;
@property (weak, nonatomic) IBOutlet UIImageView *organizationIV1;//机构图片
@property (weak, nonatomic) IBOutlet UIImageView *organizationIV2;
@property (weak, nonatomic) IBOutlet UILabel *organizationTagLabel;
@property (weak, nonatomic) IBOutlet UIButton *historyCommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *bookCountBtn;
@property (weak, nonatomic) IBOutlet UILabel *organizationTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *organizationAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *bookingBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;

@property (weak, nonatomic) IBOutlet UIImageView *starIV1;
@property (weak, nonatomic) IBOutlet UIImageView *starIV2;
@property (weak, nonatomic) IBOutlet UIImageView *starIV3;
@property (weak, nonatomic) IBOutlet UIImageView *starIV4;
@property (weak, nonatomic) IBOutlet UIImageView *starIV5;
@property (weak, nonatomic) IBOutlet UIImageView *authImageView;

@property (nonatomic, strong) ApiOrganizationDetailRequest *apiDetail;
@property (nonatomic, strong) ApiAddBookRequest *apiAddBook;
@property (nonatomic, strong) OrganizationModel *organizationModel;

@end

@implementation OrganizationDetailViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"机构信息";
    
    self.organizationIV1.userInteractionEnabled =self.organizationIV2.userInteractionEnabled= self.organizationIV3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage1)];
    [self.organizationIV1 addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage2)];
    [self.organizationIV2 addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage3)];
    [self.organizationIV3 addGestureRecognizer:tap3];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
    
    self.apiDetail = [[ApiOrganizationDetailRequest alloc] initWithDelegate:self];
    [self.apiDetail setApiParamsWithLoginAccounts:self.loginAccounts currentLogin:[AccountManager sharedInstance].account.loginAccounts];
    [APIClient execute:self.apiDetail];
    [HUDManager showLoadingHUDView:self.view];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {

    [HUDManager hideHUDView];
    if (api == self.apiDetail) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [AlertViewManager showAlertViewWithMessage:kDefaultNetWorkErrorString];
    
}

- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(APIResult *)sr {

    [HUDManager hideHUDView];
    
    if (sr.dic == nil || [sr.dic isKindOfClass:[NSNull class]]) {
        return;
    }
    if (api == self.apiDetail) {
        
        NSDictionary *dic = [sr.dic objectForKey:@"organization"];
        self.organizationModel = [OrganizationModel initWithDic:dic];
        self.organizationModel.isCollect = [ValueUtils stringFromObject:[sr.dic objectForKey:@"isCollect"]];
        [self loadDataWithModel:self.organizationModel];
       
    } else if (api == self.apiAddBook) {
        
        NSString *url=[NSString stringWithFormat:@"tel://%@",self.organizationModel.loginAccounts];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr {
    if (api == self.apiDetail) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSString *message = sr.msg;
    [HUDManager hideHUDView];
    if (message.length == 0) {
        message = kDefaultServerErrorString;
    }
    [AlertViewManager showAlertViewWithMessage:message];
}

#pragma mark - 协议名
#pragma mark - event response
/**
 *  立即预约
 */
- (IBAction)appointmentBtnAction:(UIButton *)sender {
    
//    NSString *phoneStr=[NSString stringWithFormat:@"telprompt://4006666866"];
   
    //调接口 +1
    self.apiAddBook = [[ApiAddBookRequest alloc] initWithDelegate:self];
    [self.apiAddBook setApiParamsWithOrganizationId:self.organizationModel.organizationId];
    [APIClient execute:self.apiAddBook];
    [HUDManager showLoadingHUDView:self.view];
}
/**
 *  收藏
 */
- (IBAction)collectionBtnAction:(UIButton *)sender {
//    if (![AccountManager sharedInstance].isLogin) {
//        [AlertViewManager showAlertViewMessage:@"尚未登录,请登录!" handlerBlock:^{
////            kRootViewController = [SystemHandler loginViewController];
//            [self pushLoginVC];
//        }];
//        
//        return;
//    }
//    [HUDManager showLoadingHUDView:self.view];
//    if (sender.selected) {
//        //取消收藏
//        [[CancelAttentionHandler sharedInstance] cancelAttentionWithOrgId:self.organizationModel.loginAccounts success:^(NSString *result) {
//            [HUDManager hideHUDView];
//            sender.selected = !sender.selected;
//        } failure:^(NSString *message) {
//            [HUDManager hideHUDView];
//        }];
//    } else {
//        //收藏
//        [[AttentionHandler sharedInstance] attentionWithOrgId:self.organizationModel.loginAccounts success:^(NSString *result) {
//            [HUDManager hideHUDView];
//            sender.selected = !sender.selected;
//        } failure:^(NSString *message) {
//            [HUDManager hideHUDView];
//        }];
//    }
//    
    
}
/**
 *  评价
 */
- (IBAction)commentBtnAction:(UIButton *)sender {
//    if (![AccountManager sharedInstance].isLogin) {
//        [AlertViewManager showAlertViewMessage:@"尚未登录,请登录!" handlerBlock:^{
////            kRootViewController = [SystemHandler loginViewController];
//            [self pushLoginVC];
//        }];
//        
//        return;
//    }
//    CommentViewController *vc = [[CommentViewController alloc]init];
//    vc.loginAccounts = self.organizationModel.loginAccounts;
//    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  分享
 */
- (IBAction)shareBtnAction:(UIButton *)sender {
    [SharSdkManager ShareEventClicked:self.view content:@"找好晚托，上爱晚托" url:[NSString stringWithFormat:@"%@fenxiang.html?id=%@", SERVER_HOST_PRODUCT, self.organizationModel.organizationId] imageUrl:@"http://iwantuo.com:10000/1.png"];
}
/**
 *  已评价
 */
- (IBAction)valuationBtnAction:(UIButton *)sender {
    HistoryCommentViewController *historyVC = [[HistoryCommentViewController alloc] init];
    historyVC.loginAccounts = self.organizationModel.loginAccounts;
    [self.navigationController pushViewController:historyVC animated:YES];
}


#pragma mark - private methods

- (void)loadDataWithModel:(OrganizationModel *)model {
    
    if (model.introduce.length == 0) {
        self.organizationDetailTV.text = @"本机构提供晚托、寒暑托服务，以培养孩子良好的学习习惯，生活习惯及综合能力为理念，以一切为了孩子为宗旨；让您的孩子爱上学习、让家长工作无忧。";
    } else {
       self.organizationDetailTV.text = model.introduce;
    }
    
    self.organizationNameLabel.text = model.organization;
    
    //设置上面三个图
    if (model.photoAlbum.length) {
        NSArray *arr = [model.photoAlbum componentsSeparatedByString:@","];
        for (int i = 0; i < arr.count; i++) {
            NSString *url = arr[i];
            if ([url hasPrefix:@"http://www"]) {
                url = url;
            }else{
                url = [NSString stringWithFormat:@"%@%@",@"http://www.",url];
            }

            if (i == 0) {
                [self.organizationIV1 sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"organization_place1"]];
            }
            if (i == 1) {
                [self.organizationIV2 sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"organization_place2"]];
            }
            if (i == 2) {
                [self.organizationIV3 sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"organization_place3"]];
            }
            
        }
    }
    self.organizationTagLabel.text = model.label;
    [self.historyCommentBtn setTitle:[NSString stringWithFormat:@"%@人已评价", model.evaluateNum] forState:(UIControlStateNormal)];
    [self.bookCountBtn setTitle:[NSString stringWithFormat:@"%@人已预约", model.orderNum] forState:(UIControlStateNormal)];
    
    //设置机构类型
    if (model.organizatioType.integerValue == 0) {
        self.organizationTypeLabel.text = @"工作室";
    } else {
        self.organizationTypeLabel.text = @"公司";
    }
    
    [self.organizationAddressBtn setTitle:model.address forState:(UIControlStateNormal)];
    
    //设置收藏按钮
    if (model.isCollect.integerValue == 1) {
        self.collectionBtn.selected = YES;
    } else {
        self.collectionBtn.selected = NO;
    }

    //设置星级~~
    switch (model.evaluate.integerValue) {
        case 5:
        {
            self.starIV5.image = [UIImage imageNamed:@"organization_StarYellow"];
        }
        case 4:
        {
            self.starIV4.image = [UIImage imageNamed:@"organization_StarYellow"];
        }
        case 3:
        {
            self.starIV3.image = [UIImage imageNamed:@"organization_StarYellow"];
        }
        case 2:
        {
            self.starIV2.image = [UIImage imageNamed:@"organization_StarYellow"];
        }
        case 1:
        {
            self.starIV1.image = [UIImage imageNamed:@"organization_StarYellow"];
        }
        default:
            break;
    }
    
    if (model.attestation.integerValue == 2) {
        self.authImageView.hidden = NO;
    } else {
        //未认证
        self.authImageView.hidden = YES;
    }
}

- (void)pushLoginVC
{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (void)magnifyImage1{
    [ImageZoomTap showImage:self.organizationIV1];//调用方法
}
- (void)magnifyImage2{
    [ImageZoomTap showImage:self.organizationIV2];//调用方法
}
- (void)magnifyImage3{
    [ImageZoomTap showImage:self.organizationIV3];//调用方法
}

@end
