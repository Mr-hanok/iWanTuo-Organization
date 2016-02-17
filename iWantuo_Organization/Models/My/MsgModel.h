//
//  MsgModel.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/2/16.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgModel : NSObject

@property (nonatomic, copy) NSString *msgId; //
@property (nonatomic, copy) NSString *push_login_accounts; //推送人帐号
@property (nonatomic, copy) NSString *login_accounts; //接收人帐号
@property (nonatomic, copy) NSString *create_date; //推送时间
@property (nonatomic, copy) NSString *status; //
@property (nonatomic, copy) NSString *status_name; //2代表未读 3代表已读
@property (nonatomic, copy) NSString *push_details; //推送内容
@property (nonatomic, copy) NSString *push_name; //推送人姓名
@property (nonatomic, copy) NSString *push_type; //1手机端机构个人推送 2后台管理员群推

+ (MsgModel *)initWithDic:(NSDictionary *)dic;

@end
//id: 8,
//push_login_accounts: "185", 推送人帐号
//login_accounts: "185", 接收人帐号
//create_date: "2016-01-25 10:56:28.0", 推送时间
//status: 2, 2代表未读 3代表已读
//status_name: null,
//push_details: "", 推送内容
//push_name: "185", 推送人姓名
//push_type: 1 1手机端机构个人推送 2后台管理员群推
