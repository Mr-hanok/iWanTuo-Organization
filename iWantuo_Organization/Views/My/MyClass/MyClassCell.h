//
//  MyClassCell.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//
@protocol MyClassCellDelegate <NSObject>

- (void)myClassCellCliecDeleBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row;
@end
#import <UIKit/UIKit.h>
/**
 *  班级管理cell
 */
@interface MyClassCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;//班级名
@property (weak, nonatomic) IBOutlet UILabel *studentCountLabel;//人数
@property (nonatomic, assign) NSInteger row;

@property (nonatomic, weak) id<MyClassCellDelegate> delegate;
+ (MyClassCell *)shareMyClassCell;
@end
