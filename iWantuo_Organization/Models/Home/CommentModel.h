//
//  CommentModel.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/25.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic, copy) NSString *commentId; //
@property (nonatomic, copy) NSString *organizationAccounts; //机构帐号
@property (nonatomic, copy) NSString *evaluate; //评论星级
@property (nonatomic, copy) NSString *evaluatePerson; //  "游客", 评论人
@property (nonatomic, copy) NSString *evaluateDetails; //评论内容
@property (nonatomic, copy) NSString *createDate; // 评论时间
@property (nonatomic, copy) NSString *status; //
@property (nonatomic, copy) NSString *statusName; //"可用"
@property (nonatomic, copy) NSString *headPortrait; //头像

+ (CommentModel *)initWithDic:(NSDictionary *)dic;
@end
