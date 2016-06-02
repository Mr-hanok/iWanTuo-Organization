//
//  OrganizationCell.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "OrganizationCell.h"

@implementation OrganizationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - public
+ (UINib *)nibWithCell {
    return [UINib nibWithNibName:@"OrganizationCell" bundle:nil];
}

#pragma mark -
- (void)configWithModel:(OrganizationModel *)model {
    if ([model.distance integerValue] < 1000) {
        self.distanceLabel.text = [NSString stringWithFormat:@"%@m", @([model.distance integerValue])];
    } else {
        self.distanceLabel.text = [NSString stringWithFormat:@"%.1fkm",[model.distance integerValue] / 1000.0];
    }
    
    self.organization_nameLabel.text = model.organization;
    self.organization_addressLabel.text = model.address;
    switch ([model.evaluate integerValue]) {
        case 5:
            self.organization_fifthStar.selected = YES;
            self.organization_fourthStar.selected = YES;
            self.organization_thirdStar.selected = YES;
            self.organization_secondStar.selected = YES;
            self.organization_firstStar.selected = YES;
            break;
        case 4:
            self.organization_fifthStar.selected = NO;
            self.organization_fourthStar.selected = YES;
            self.organization_thirdStar.selected = YES;
            self.organization_secondStar.selected = YES;
            self.organization_firstStar.selected = YES;
            break;
        case 3:
            self.organization_fifthStar.selected = NO;
            self.organization_fourthStar.selected = NO;
            self.organization_thirdStar.selected = YES;
            self.organization_secondStar.selected = YES;
            self.organization_firstStar.selected = YES;
            break;
        case 2:
            self.organization_fifthStar.selected = NO;
            self.organization_fourthStar.selected = NO;
            self.organization_thirdStar.selected = NO;
            self.organization_secondStar.selected = YES;
            self.organization_firstStar.selected = YES;
            break;
        case 1:
            self.organization_fifthStar.selected = NO;
            self.organization_fourthStar.selected = NO;
            self.organization_thirdStar.selected = NO;
            self.organization_secondStar.selected = NO;
            self.organization_firstStar.selected = YES;
            break;
        default:
            break;
    }
}

@end
