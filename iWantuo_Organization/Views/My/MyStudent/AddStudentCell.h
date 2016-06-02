//
//  AddStudentCell.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddStudentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *attributeNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *attributeValueLabel;

#pragma mark - public
+ (UINib *)nibWithCell;
@end
