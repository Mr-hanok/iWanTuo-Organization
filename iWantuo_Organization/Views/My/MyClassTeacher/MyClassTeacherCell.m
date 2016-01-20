//
//  MyClassTeacherCell.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyClassTeacherCell.h"

@implementation MyClassTeacherCell
+ (MyClassTeacherCell *)shareMyClassTeacherCell{
    return[[[NSBundle mainBundle]loadNibNamed:@"MyClassTeacherCell" owner:nil options:0]firstObject];
}
- (IBAction)deleteBenAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(myClassTeacherCellCliecDeleBtn:withIndexPathRow:)]) {
        [self.delegate myClassTeacherCellCliecDeleBtn:sender withIndexPathRow:self.row];
    }

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
