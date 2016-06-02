//
//  OrganizationCell.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrganizationModel.h"

@interface OrganizationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *organization_nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *organization_firstStar;
@property (weak, nonatomic) IBOutlet UIButton *organization_secondStar;
@property (weak, nonatomic) IBOutlet UIButton *organization_thirdStar;
@property (weak, nonatomic) IBOutlet UIButton *organization_fourthStar;
@property (weak, nonatomic) IBOutlet UIButton *organization_fifthStar;
@property (weak, nonatomic) IBOutlet UILabel *organization_addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

+ (UINib *)nibWithCell;
- (void)configWithModel:(OrganizationModel *)model;
@end
