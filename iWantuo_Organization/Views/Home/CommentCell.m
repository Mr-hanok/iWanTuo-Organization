//
//  CommentCell.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "CommentCell.h"

#import "NSString+Size.h"

@implementation CommentCell


#pragma mark - public
+ (UINib *)nibWithCell {
    return [UINib nibWithNibName:@"CommentCell" bundle:nil];
}
+ (CGFloat)cellHeightWithModel:(CommentModel *)model {
    return 97 - 21 + [model.evaluateDetails sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(kScreenBoundWidth - 16, 0)].height;;
}

- (void)configWithModel:(CommentModel *)model {

    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.%@", model.headPortrait]] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    if (model.evaluatePerson.length >= 7) {
        NSMutableString *account = [NSMutableString stringWithFormat:@"%@", model.evaluatePerson];//[model.evaluatePerson replaceCharactersInRange:NSMakeRange(0, 4) withString:@"That"]
        [account replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.userAccountLabel.text = account;
    } else {
        self.userAccountLabel.text = model.evaluatePerson;
    }   
   
    self.commentLabel.text = model.evaluateDetails;
    self.commentTimeLabel.text = [model.createDate substringToIndex:10];
    self.commentHeightConstraint.constant = [model.evaluateDetails sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(self.commentLabel.frame.size.width, 0)].height;

}
- (void)awakeFromNib {
    // Initialization code
    self.userImageView.layer.cornerRadius = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
