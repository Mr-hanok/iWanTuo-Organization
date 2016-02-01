//
//  CommentCell.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeightConstraint;

+ (UINib *)nibWithCell;
+ (CGFloat)cellHeightWithModel:(CommentModel *)model;
- (void)configWithModel:(CommentModel *)model;
@end
