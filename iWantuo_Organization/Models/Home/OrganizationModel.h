//
//  OrganizationModel.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrganizationModel : NSObject

@property (nonatomic, copy) NSString *organizationId; //机构id
@property (nonatomic, copy) NSString *location;       //城市编号
@property (nonatomic, copy) NSString *locationName;   //城市名称
@property (nonatomic, copy) NSString *bairro;         //区
@property (nonatomic, copy) NSString *bairroName;     //区名称
@property (nonatomic, copy) NSString *address;        //详细地址
@property (nonatomic, copy) NSString *loginAccounts;//登录帐号
@property (nonatomic, copy) NSString *email;//邮箱
@property (nonatomic, copy) NSString *organizatioType; //机构类型 0 工作室  1公司
@property (nonatomic, copy) NSString *organizatioTypeName; //机构类型名称
@property (nonatomic, copy) NSString *organizationAbbreviation;//机构简称
@property (nonatomic, copy) NSString *organization;//机构全称
@property (nonatomic, copy) NSString *organizationContacts;//机构联系人
@property (nonatomic, copy) NSString *idCardImage;//身份证图片
@property (nonatomic, copy) NSString *businessLicenseImage;//营业执照图片
@property (nonatomic, copy) NSString *coordinateX;//x坐标
@property (nonatomic, copy) NSString *coordinateY;//y坐标
@property (nonatomic, copy) NSString *phone;//联系电话
@property (nonatomic, copy) NSString *idCard;//身份证号
@property (nonatomic, copy) NSString *businessLicense;//营业执照
@property (nonatomic, copy) NSString *createDate;//创建日期
@property (nonatomic, copy) NSString *updateDate;//修改日期
@property (nonatomic, copy) NSString *check;//
@property (nonatomic, copy) NSString *checkName;//
@property (nonatomic, copy) NSString *attestation;// 认证状态(1未认证2已认证)
@property (nonatomic, copy) NSString *attestationName; //认证状态名称
@property (nonatomic, copy) NSString *warranty;//授权状态(0失效1暂停2生效)
@property (nonatomic, copy) NSString *warrantyName;//授权状态名称
@property (nonatomic, copy) NSString *introduce;//介绍
@property (nonatomic, copy) NSString *label;//标签
@property (nonatomic, copy) NSString *photoAlbum;// 效果图（相册）
@property (nonatomic, copy) NSString *cost;//价格
@property (nonatomic, copy) NSString *orderNum;//预约单数
@property (nonatomic, copy) NSString *evaluate;//评价星数
@property (nonatomic, copy) NSString *evaluateNum;//评价个数
@property (nonatomic, copy) NSString *subject; //学科
@property (nonatomic, copy) NSString *teacher; //班主任
@property (nonatomic, copy) NSString *headPortrait;//头像
@property (nonatomic, copy) NSString *isCollect;//是否关注 0未关注 1关注
@property (nonatomic, copy) NSString *distance;
+ (OrganizationModel *)initWithDic:(NSDictionary *)dic;

@end
