//
//  MyNewsTableViewCell.h
//  iStudentHosting
//
//  Created by Lisa on 16/1/28.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgModel.h"
/**
 *  我的消息的cell
 */
@interface MyNewsTableViewCell : UITableViewCell

+ (UINib *)nibOfNewsCell;

- (void)configCellWithModel:(MsgModel *)model;

@end
