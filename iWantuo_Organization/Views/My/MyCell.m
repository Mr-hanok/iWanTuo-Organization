//
//  MyCell.m
//  iStudentHosting
//
//  Created by yuntai on 16/1/14.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

+ (MyCell *)shareMyCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:0]firstObject];
}
+ (MyCell *)shareMyTypeCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:0]lastObject];
}
- (void)awakeFromNib {
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    //设置头像圆形
    self.headIV.layer.cornerRadius = self.headIV.bounds.size.width/2;
    self.headIV.layer.masksToBounds = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    switch (self.row) {
        case 1:
            self.typeLabel.text = @"每日跟踪";
            self.typeIV.image = [UIImage imageNamed:@"my_follow"];
            break;
        case 2:
            self.typeLabel.text = @"学生管理";
            self.typeIV.image = [UIImage imageNamed:@"my_ student"];
            break;
        case 3:
            self.typeLabel.text = @"我的消息";
            self.typeIV.image = [UIImage imageNamed:@"my_message"];
            break;
        case 4:
            self.typeLabel.text = @"班级管理";
            self.typeIV.image = [UIImage imageNamed:@"my_class"];
            break;
        case 5:
            self.typeLabel.text = @"辅导老师管理";
            self.typeIV.image = [UIImage imageNamed:@"my_classteacher"];
            break;
        case 6:
            self.typeLabel.text = @"推送消息";
            self.typeIV.image = [UIImage imageNamed:@"my_pushMessage"];
            break;
        case 7:
            self.typeLabel.text = @"设置";
            self.typeIV.image = [UIImage imageNamed:@"setting"];
            break;

    }
}
@end
