//
//  ClassDetailCell.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ClassDetailCell.h"

@implementation ClassDetailCell
+ (ClassDetailCell *)shareMyCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"ClassDetailCell" owner:nil options:0]firstObject];
}
- (IBAction)seleteBtnAction:(UIButton *)sender {//选择按钮
    if ([self.delegate respondsToSelector:@selector(classDetailCellSeletBtn:withIndexPathRow:)]) {
        [self.delegate classDetailCellSeletBtn:sender withIndexPathRow:self.row];
    }
}

- (void)configCellWithModel:(StudentModel *)model {
    self.nameLabel.text = model.name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
