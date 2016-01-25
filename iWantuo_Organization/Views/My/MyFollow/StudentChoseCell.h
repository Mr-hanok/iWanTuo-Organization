//
//  StudentChoseCell.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/22.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentChoseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (StudentChoseCell *)shareStudentChoseCell;
@end
