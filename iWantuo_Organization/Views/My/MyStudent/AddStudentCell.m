//
//  AddStudentCell.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AddStudentCell.h"

@implementation AddStudentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - public
+ (UINib *)nibWithCell {
    return [UINib nibWithNibName:@"AddStudentCell" bundle:nil];
}


@end
