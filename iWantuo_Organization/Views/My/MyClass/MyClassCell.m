//
//  MyClassCell.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyClassCell.h"

@implementation MyClassCell
+ (MyClassCell *)shareMyClassCell{
    return[[[NSBundle mainBundle]loadNibNamed:@"MyClassCell" owner:nil options:0]firstObject];
}
- (IBAction)deleteBtnAction:(UIButton *)sender {//删除按钮点击
    if ([self.delegate respondsToSelector:@selector(myClassCellCliecDeleBtn:withIndexPathRow:)]) {
        [self.delegate myClassCellCliecDeleBtn:sender withIndexPathRow:self.row];
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
