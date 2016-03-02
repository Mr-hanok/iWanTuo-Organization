//
//  MCGrowCurveViewController.m
//  iStudentHosting
//
//  Created by 陈腾飞 on 16/1/24.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MCGrowCurveViewController.h"
#import "UUChart.h"
#import "ApiGrowCurveRequest.h"
#import "ApiGrowAvgRequest.h"
#import "ZHPickView.h"
#import "NSDate+FSExtension.h"

@interface MCGrowCurveViewController ()<UUChartDataSource, APIRequestDelegate, ZHPickViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *overLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedDateBtn;

@property (weak, nonatomic) IBOutlet UIView *behaviourChartView;
@property (weak, nonatomic) IBOutlet UIView *studyChartView;
@property (weak, nonatomic) IBOutlet UIView *comprehensiveChartView;
@property (nonatomic, strong) ZHPickView *pickView;

@property (nonatomic, strong) ApiGrowCurveRequest *api;
@property (nonatomic, strong) ApiGrowAvgRequest *apiAvg;

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *behaviorArray;
@property (nonatomic, strong) NSMutableArray *growArray;
@property (nonatomic, strong) NSMutableArray *comprehensiveArray;

@property (nonatomic, strong) NSString *overRun;

@end

@implementation MCGrowCurveViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleArray = [NSMutableArray array];
        self.behaviorArray = [NSMutableArray array];
        self.growArray = [NSMutableArray array];
        self.comprehensiveArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"成长曲线";
    NSDate *date = [NSDate date];
    NSInteger time = date.timeIntervalSince1970;
    
    [HUDManager showLoadingHUDView:KeyWindow];
    self.api = [[ApiGrowCurveRequest alloc] initWithDelegate:self];
    [self.api setApiParamesWithStudentId:self.studentId createDate:[NSString stringWithFormat:@"%@", @(time)]];
    [APIClient execute:self.api];
    
    self.apiAvg = [[ApiGrowAvgRequest alloc] initWithDelegate:self];
    [self.apiAvg setApiParamesWithStudentId:self.studentId createDate:[NSString stringWithFormat:@"%@", @(time)]];
    [APIClient execute:self.apiAvg];
    
    
    [self.selectedDateBtn setTitle:[date fs_stringWithFormat:@"yyyy年MM月"] forState:UIControlStateNormal];
    

    [self setupPickView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"成长曲线"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"成长曲线"];
    [self.pickView remove];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        
        if (api == self.api) {
            [self.titleArray removeAllObjects];
            [self.behaviorArray removeAllObjects];
            [self.growArray removeAllObjects];
            self.overRun = [ValueUtils stringFromObject:[sr.dic objectForKey:@"average"]];
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您的孩子打败了'爱晚托'同级%@%%的同学!", self.overRun]];
            [str addAttribute:NSForegroundColorAttributeName value:kNavigationColor range:NSMakeRange(14,self.overRun.length + 1)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:20] range:NSMakeRange(14,self.overRun.length + 1)];
            self.overLabel.attributedText = str;
            
            NSArray *array = [sr.dic objectForKey:@"traceList"];
            for (NSDictionary *dic in array) {
                //
                NSString *str = [dic objectForKey:@"createDate"];
                NSInteger length = str.length - 2;
                NSRange range = {length, 2};
                str = [str substringWithRange:range];
                [self.titleArray addObject:[ValueUtils stringFromObject:str]];
                [self.behaviorArray addObject:[ValueUtils stringFromObject:[dic objectForKey:@"behavior"]]];
                [self.growArray addObject:[ValueUtils stringFromObject:[dic objectForKey:@"study"]]];
            }
            
            [self setupChartView];
        } else if (api == self.apiAvg) {
            [self.comprehensiveArray removeAllObjects];
            NSArray *array = [sr.dic objectForKey:@"traceList"];
            for (NSDictionary *dic in array) {
                [self.comprehensiveArray addObject:[ValueUtils stringFromObject:[dic objectForKey:@"average"]]];
            }
            [self setupAvgChartView];
        }
        
    } else {
        [HUDManager showWarningWithText:sr.msg];
        [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString level1:(NSString *)level1 row1:(NSInteger)row1 row2:(NSInteger)row2 {
    
    NSString *yearStr = [level1 substringToIndex:(level1.length - 1)];
    NSString *montthStr = [resultString substringToIndex:(resultString.length - 1)];
    NSDate *selectDate = [NSDate fs_dateWithYear:[yearStr integerValue] month:[montthStr integerValue] day:1];
    
    [self.selectedDateBtn setTitle:[selectDate fs_stringWithFormat:@"yyyy年MM月"] forState:UIControlStateNormal];
    
    [HUDManager showLoadingHUDView:KeyWindow];
    [self.api setApiParamesWithStudentId:self.studentId createDate:[NSString stringWithFormat:@"%@", @(selectDate.timeIntervalSince1970)]];
    [APIClient execute:self.api];
}

#pragma mark - UUChartDataSource
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart {
    
    return self.titleArray;
}

//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart {

    
    if (chart.tag == 6000001) {
        return @[self.behaviorArray];
    } else if ((chart.tag == 6000002)){
        return @[self.growArray];
    } else {
        return @[self.comprehensiveArray];
    }
}

- (CGRange)chartRange:(UUChart *)chart {
    
    return CGRangeMake(5, 1);
}

- (NSArray *)chartConfigColors:(UUChart *)chart {
    return @[kNavigationColor];
}

- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index {
    return YES;
}


#pragma mark - event response
- (IBAction)selectDateBtnClick:(UIButton *)sender {
    
    [self.pickView show];
}


#pragma mark - private methods

- (void)setupChartView {
    
    CGFloat chartViewWidht = kScreenBoundWidth - 2 * 15;
    CGFloat chartViewHeight = chartViewWidht / (369.0 / 158.0);
    UUChart *behaviourChart = [[UUChart alloc] initWithFrame:CGRectMake(0, 0, chartViewWidht, chartViewHeight) dataSource:self style:UUChartStyleLine];
    behaviourChart.tag = 6000000 + 1;
    
    UUChart *studyChart = [[UUChart alloc] initWithFrame:CGRectMake(0, 0, chartViewWidht, chartViewHeight) dataSource:self style:UUChartStyleLine];
    studyChart.tag = 6000000 + 2;
    
    [behaviourChart showInView:self.behaviourChartView];
    [studyChart showInView:self.studyChartView];
}

- (void)setupAvgChartView {
    CGFloat chartViewWidht = kScreenBoundWidth - 2 * 15;
    CGFloat chartViewHeight = chartViewWidht / (369.0 / 158.0);
    UUChart *avgChart = [[UUChart alloc] initWithFrame:CGRectMake(0, 0, chartViewWidht, chartViewHeight) dataSource:self style:UUChartStyleLine];
    avgChart.tag = 6000000 + 3;
    
    [avgChart showInView:self.comprehensiveChartView];
}

/**
 *  @brief 设置pickDateView
 */
- (void)setupPickView {

    NSDate *currentDate = [NSDate date];
    NSMutableArray *pickYearArray = [NSMutableArray arrayWithCapacity:100];
    for (NSInteger i = 0; i < 100; i++) {
        [pickYearArray addObject:[NSString stringWithFormat:@"%@年", @(currentDate.fs_year - i)]];
    }
    NSArray *pickMonthYear = @[@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月"];
    
    self.pickView = [[ZHPickView alloc] initPickviewWithArray:@[pickYearArray, pickMonthYear] isHaveNavControler:NO];
    self.pickView.delegate = self;
    
}
@end
