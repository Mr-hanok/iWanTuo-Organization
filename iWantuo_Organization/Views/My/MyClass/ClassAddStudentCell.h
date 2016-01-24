//
//  ClassAddStudentCell.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//
@protocol ClassAddStudentCellDelegate <NSObject>

- (void)classAddStudentCellSeletBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row;
@end

#import <UIKit/UIKit.h>
#import "StudentModel.h"
/**
 *  向班级添加学生cell
 */
@interface ClassAddStudentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *parentAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

+ (ClassAddStudentCell *)shareMyCell;
- (void)configCellWithModel:(StudentModel *)model;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, weak) id<ClassAddStudentCellDelegate> delegate;
@end
