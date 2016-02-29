//
//  TopViewController.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/6.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "TopViewController.h"
#import "TopListViewController.h"
#import "ApiActiveRequest.h"
#import "ActivityModel.h"
//#import "ActivityDetailViewController.h"
#import "WebHudViewController.h"

@interface TopViewController ()<APIRequestDelegate>

@property (nonatomic, strong) ApiActiveRequest *api;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *top1IV;
@property (weak, nonatomic) IBOutlet UIImageView *top2IV;
@property (weak, nonatomic) IBOutlet UIImageView *top3IV;
@property (weak, nonatomic) IBOutlet UIImageView *top4IV;
@property (weak, nonatomic) IBOutlet UIImageView *top5IV;

@end

@implementation TopViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"广场";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.topImageView bk_whenTapped:^{
        TopListViewController *listVC = [[TopListViewController alloc] init];
        listVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:listVC animated:YES];
    }];
    
    self.api = [[ApiActiveRequest alloc] initWithDelegate:self];
    [APIClient execute:self.api];
    [HUDManager showLoadingHUDView:KeyWindow];
    
    [self.top1IV bk_whenTapped:^{
        if (self.dataArray.count >= 1){
            WebHudViewController *detailVC = [[WebHudViewController alloc] init];
            ActivityModel *model = [self.dataArray objectAtIndex:0];
            detailVC.webUrl = [NSString stringWithFormat:@"http://www.iwantuo.com/phoneImg.html?id=%@", model.activityId];
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }];
    
    [self.top2IV bk_whenTapped:^{
        if (self.dataArray.count >= 2){
            WebHudViewController *detailVC = [[WebHudViewController alloc] init];
            ActivityModel *model = [self.dataArray objectAtIndex:1];
            detailVC.webUrl = [NSString stringWithFormat:@"http://www.iwantuo.com/phoneImg.html?id=%@", model.activityId];
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }];
    
    [self.top3IV bk_whenTapped:^{
        if (self.dataArray.count >= 3){
            WebHudViewController *detailVC = [[WebHudViewController alloc] init];
            ActivityModel *model = [self.dataArray objectAtIndex:2];
            detailVC.webUrl = [NSString stringWithFormat:@"http://www.iwantuo.com/phoneImg.html?id=%@", model.activityId];
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }];
    
    [self.top4IV bk_whenTapped:^{
        if (self.dataArray.count >= 4){
            WebHudViewController *detailVC = [[WebHudViewController alloc] init];
            ActivityModel *model = [self.dataArray objectAtIndex:3];
            detailVC.webUrl = [NSString stringWithFormat:@"http://www.iwantuo.com/phoneImg.html?id=%@", model.activityId];
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }];
    
    [self.top5IV bk_whenTapped:^{
        if (self.dataArray.count >= 5){
            WebHudViewController *detailVC = [[WebHudViewController alloc] init];
            ActivityModel *model = [self.dataArray objectAtIndex:4];
            detailVC.webUrl = [NSString stringWithFormat:@"http://www.iwantuo.com/phoneImg.html?id=%@", model.activityId];
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }];
    
    self.top1IV.layer.masksToBounds = YES;
    self.top1IV.layer.cornerRadius = 8;
    
    self.top2IV.layer.masksToBounds = YES;
    self.top2IV.layer.cornerRadius = 8;
    
    self.top3IV.layer.masksToBounds = YES;
    self.top3IV.layer.cornerRadius = 8;
    
    self.top4IV.layer.masksToBounds = YES;
    self.top4IV.layer.cornerRadius = 8;
    
    self.top5IV.layer.masksToBounds = YES;
    self.top5IV.layer.cornerRadius = 8;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"广场"];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"广场"];
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
        self.dataArray = [NSMutableArray array];
        NSArray *array = [sr.dic objectForKey:@"ActivityList"];
        for (NSDictionary *dic in array) {
            ActivityModel *model = [ActivityModel initWithDic:dic];
            [self.dataArray addObject:model];
        }
        //赋值~~
        for (ActivityModel *model in self.dataArray) {
            if (model.location.integerValue == 1) {
                [self.top1IV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.thumbnailPath]] placeholderImage:[UIImage imageNamed:@"DefaultImage"]];
            }
            if (model.location.integerValue == 2) {
                [self.top2IV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.thumbnailPath]] placeholderImage:[UIImage imageNamed:@"DefaultImage"]];
            }
            if (model.location.integerValue == 3) {
                [self.top3IV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.thumbnailPath]] placeholderImage:[UIImage imageNamed:@"DefaultImage"]];
            }
            if (model.location.integerValue == 4) {
                [self.top4IV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.thumbnailPath]] placeholderImage:[UIImage imageNamed:@"DefaultImage"]];
            }
            if (model.location.integerValue == 5) {
                [self.top5IV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.thumbnailPath]] placeholderImage:[UIImage imageNamed:@"DefaultImage"]];
            }
        }
        
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


@end
