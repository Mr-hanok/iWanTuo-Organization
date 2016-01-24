//
//  ClassDetailCell.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//
@protocol ClassDetailCellDelegate <NSObject>

- (void)classDetailCellSeletBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row;
@end
#import <UIKit/UIKit.h>
#import "StudentModel.h"
/**
 *  班级详情cell
 */
@interface ClassDetailCell : UITableViewCell
@property (nonatomic, assign) NSInteger row;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (nonatomic, weak) id<ClassDetailCellDelegate> delegate;
+ (ClassDetailCell *)shareMyCell;
- (void)configCellWithModel:(StudentModel *)model;
@end
