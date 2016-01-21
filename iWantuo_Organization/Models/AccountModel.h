//
//  AccountModel.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/20.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject

/**后台表id*/
@property (nonatomic, copy) NSString *userId;
/**城市id*/
@property (nonatomic, copy) NSString *location;
/**城市名称*/
@property (nonatomic, copy) NSString *locationName;
/**区*/
@property (nonatomic, copy) NSString *bairro;
/**区名称*/
@property (nonatomic, copy) NSString *bairroName;
/**详细地址*/
@property (nonatomic, copy) NSString *address;
/**帐号*/
@property (nonatomic, copy) NSString *loginAccounts;
/**邮箱*/
@property (nonatomic, copy) NSString *email;
/**机构类型*/
@property (nonatomic, copy) NSString *organizatioType;
/**机构类型名称*/
@property (nonatomic, copy) NSString *organizatioTypeName;
/**机构简称*/
@property (nonatomic, copy) NSString *organizationAbbreviation;
/**机构全称*/
@property (nonatomic, copy) NSString *organization;
/**机构联系人*/
@property (nonatomic, copy) NSString *organizationContacts;
/**身份证图片*/
@property (nonatomic, copy) NSString *idCardImage;
/**营业执照图片*/
@property (nonatomic, copy) NSString *businessLicenseImage;
/**x坐标*/
@property (nonatomic, copy) NSString *coordinateX;
/**y坐标*/
@property (nonatomic, copy) NSString *coordinateY;
/**联系电话*/
@property (nonatomic, copy) NSString *phone;
/**身份证号*/
@property (nonatomic, copy) NSString *idCard;
/**营业证号*/
@property (nonatomic, copy) NSString *businessLicense;
/***/
@property (nonatomic, copy) NSString *createDate;
/***/
@property (nonatomic, copy) NSString *updateDate;
/**审核状态*/
@property (nonatomic, copy) NSString *check;
/**审核状态*/
@property (nonatomic, copy) NSString *checkName;
/**1未认证2已认证*/
@property (nonatomic, copy) NSString *attestation;
/**认证状态名称*/
@property (nonatomic, copy) NSString *attestationName;
/**授权状态(0失效1暂停2生效)*/
@property (nonatomic, copy) NSString *warranty;
/**授权状态(0失效1暂停2生效)*/
@property (nonatomic, copy) NSString *warrantyName;
/**介绍*/
@property (nonatomic, copy) NSString *introduce;
/**标签*/
@property (nonatomic, copy) NSString *label;
/**标签*/
@property (nonatomic, copy) NSString *photoAlbum;
/**价格*/
@property (nonatomic, copy) NSString *cost;
/**预约单数*/
@property (nonatomic, copy) NSString *orderNum;
/**评价星数*/
@property (nonatomic, copy) NSString *evaluate;
/**评价个数*/
@property (nonatomic, copy) NSString *evaluateNum;
/**学科*/
@property (nonatomic, copy) NSString *subject;
/**班主任*/
@property (nonatomic, copy) NSString *teacher;
/**头像*/
@property (nonatomic, copy) NSString *headPortrait;
/**0没有关注 1关注*/
@property (nonatomic, copy) NSString *isCollect;
/***/
@property (nonatomic, copy) NSString *type;



/**1家长，2机构，3老师*/
@property (nonatomic, copy) NSString *accountsType;
/**是否登陆*/
@property (nonatomic, strong) NSString *isLogin;


+ (AccountModel *)initWithDict:(NSDictionary *)dict;

@end

#pragma mark  -  老师模型
@interface TeacherAccountModel : NSObject

+ (AccountModel *)initWithDict:(NSDictionary *)dict;

@end