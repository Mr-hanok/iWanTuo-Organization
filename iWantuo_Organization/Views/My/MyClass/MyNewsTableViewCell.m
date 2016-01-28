//
//  MyNewsTableViewCell.m
//  iStudentHosting
//
//  Created by Lisa on 16/1/28.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "MyNewsTableViewCell.h"


@interface MyNewsTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@end

@implementation MyNewsTableViewCell

+ (UINib *)nibOfNewsCell
{
    return [UINib nibWithNibName:@"MyNewsTableViewCell" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = kBGColor.CGColor;
    self.layer.borderWidth = 0.5f;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
