//
//  MyClassCell.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//
@protocol MyClassCellDelegate <NSObject>

- (void)myClassCellCliecDeleBtn:(UIButton *)btn withIndexPath:(NSIndexPath *)indexPath;
@end
#import <UIKit/UIKit.h>
#import "ClassModel.h"
/**
 *  班级管理cell
 */
@interface MyClassCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleBtn;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;//班级名
@property (weak, nonatomic) IBOutlet UILabel *studentCountLabel;//人数
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<MyClassCellDelegate> delegate;
+ (MyClassCell *)shareMyClassCell;
- (void)configWithModel:(ClassModel *)model;
@end
