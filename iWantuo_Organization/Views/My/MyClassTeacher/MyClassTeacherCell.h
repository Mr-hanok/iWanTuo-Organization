//
//  MyClassTeacherCell.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//
@protocol MyClassTeacherCellDelegate <NSObject>

- (void)myClassTeacherCellCliecDeleBtn:(UIButton *)btn withIndexPathRow:(NSInteger)row;
@end

#import <UIKit/UIKit.h>

@interface MyClassTeacherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherAccoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, assign) id<MyClassTeacherCellDelegate> delegate;
+ (MyClassTeacherCell *)shareMyClassTeacherCell;

@end
