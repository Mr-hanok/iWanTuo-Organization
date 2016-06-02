//
//  SchoolModel.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolModel : NSObject


@property (nonatomic, copy) NSString *schoolId;       //学校编号
@property (nonatomic, copy) NSString *location;       //城市编号
@property (nonatomic, copy) NSString *locationName;   //城市名称
@property (nonatomic, copy) NSString *bairro;         //地区
@property (nonatomic, copy) NSString *bairroName;     //地区名称
@property (nonatomic, copy) NSString *address;        //详细地址
@property (nonatomic, copy) NSString *email;          //邮箱
@property (nonatomic, copy) NSString *schoolName;     //学校名称
@property (nonatomic, copy) NSString *schoolContacts; //学校联系人
@property (nonatomic, copy) NSString *coordinateX;    //x坐标
@property (nonatomic, copy) NSString *coordinateY;    //y坐标
@property (nonatomic, copy) NSString *phone;          //联系电话
@property (nonatomic, copy) NSString *createDate;     //创建时间
@property (nonatomic, copy) NSString *updateDate;     //修改时间
@property (nonatomic, copy) NSString *status;         //状态
@property (nonatomic, copy) NSString *statusName;     //状态名称

+ (SchoolModel *)initWithDic:(NSDictionary *)dic;

@end
