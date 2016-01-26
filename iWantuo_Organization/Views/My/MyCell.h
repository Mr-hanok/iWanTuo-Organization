//
//  MyCell.h
//  iStudentHosting
//
//  Created by yuntai on 16/1/14.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
/**
 *  myCell
 */
@property (weak, nonatomic) IBOutlet UIImageView *headIV;//头像
@property (weak, nonatomic) IBOutlet UILabel *acountLabel;//账号
+ (MyCell *)shareMyCell;
/**
 *  myTypeCell
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeIV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWithConstran;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeLeftConstran;
+ (MyCell *)shareMyTypeCell;
@property (nonatomic, assign)NSInteger row;

@end
