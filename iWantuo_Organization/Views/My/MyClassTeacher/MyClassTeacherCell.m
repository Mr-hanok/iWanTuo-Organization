//
//  MyClassTeacherCell.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyClassTeacherCell.h"

@implementation MyClassTeacherCell

#pragma mark - public method
+ (MyClassTeacherCell *)shareMyClassTeacherCell{
    return[[[NSBundle mainBundle]loadNibNamed:@"MyClassTeacherCell" owner:nil options:0]firstObject];
}

#pragma mark - event respond
- (IBAction)deleteBenAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(myClassTeacherCellCliecDeleBtn:withIndexPath:)]) {
        [self.delegate myClassTeacherCellCliecDeleBtn:sender withIndexPath:self.indexPath];
    }

}

#pragma mark - private methods
- (void)configWithModel:(TeacherModel *)model {

    self.classNameLabel.text =  model.teacherName;
    self.teacherAccoutLabel.text = model.loginAccounts;
    self.phoneNumLabel.text = model.phone;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
