//
//  UserInfoCell.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    // Initialization code
    
    self.headImageView.layer.cornerRadius = 23;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
