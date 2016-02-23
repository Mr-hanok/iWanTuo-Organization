//
//  StudentChoseCell.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentChoseCell : UITableViewCell
/**学生姓名*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**每日表现*/
@property (weak, nonatomic) IBOutlet UIButton *GCExpressionBtn;
/**每日追踪*/
@property (weak, nonatomic) IBOutlet UIButton *GCCurveBtn;

+ (StudentChoseCell *)shareStudentChoseCell;
@end
