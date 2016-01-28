//
//  UserInfoCell.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@end
