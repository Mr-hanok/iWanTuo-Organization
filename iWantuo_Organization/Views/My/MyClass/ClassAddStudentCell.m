//
//  ClassAddStudentCell.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ClassAddStudentCell.h"

@implementation ClassAddStudentCell
+ (ClassAddStudentCell *)shareMyCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"ClassAddStudentCell" owner:nil options:0]firstObject];
}
- (IBAction)seletedBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(classAddStudentCellSeletBtn:withIndexPathRow:)]) {
        [self.delegate classAddStudentCellSeletBtn:sender withIndexPathRow:self.row];
    }

}
- (void)configCellWithModel:(StudentModel *)model {
    self.parentAccountLabel.text = model.loginAccounts;
    self.classNameLabel.text = model.grade;
    self.studentNameLabel.text = model.name;
    self.schoolNameLabel.text = model.school;
    self.selectBtn.selected = model.isAdd;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
