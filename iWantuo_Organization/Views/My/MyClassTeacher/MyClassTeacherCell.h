//
//  MyClassTeacherCell.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//
@protocol MyClassTeacherCellDelegate <NSObject>

- (void)myClassTeacherCellCliecDeleBtn:(UIButton *)btn withIndexPath:(NSIndexPath *)indexPath;
@end

#import <UIKit/UIKit.h>
#import "TeacherModel.h"

@interface MyClassTeacherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherAccoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id<MyClassTeacherCellDelegate> delegate;
+ (MyClassTeacherCell *)shareMyClassTeacherCell;
- (void)configWithModel:(TeacherModel *)model;

@end
