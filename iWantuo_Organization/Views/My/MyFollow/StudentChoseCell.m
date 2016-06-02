//
//  StudentChoseCell.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "StudentChoseCell.h"

@implementation StudentChoseCell
+ (StudentChoseCell *)shareStudentChoseCell{
    return  [[[NSBundle mainBundle]loadNibNamed:@"StudentChoseCell" owner:nil options:0]lastObject];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
