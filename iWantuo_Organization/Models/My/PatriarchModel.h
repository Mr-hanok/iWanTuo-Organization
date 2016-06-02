//
//  PatriarchModel.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/21.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatriarchModel : NSObject
@property (nonatomic, copy) NSString *patriarchId;//
@property (nonatomic, copy) NSString *loginAccounts;//
@property (nonatomic, copy) NSString *phone;//
@property (nonatomic, copy) NSString *createDate;//
@property (nonatomic, copy) NSString *status;//
@property (nonatomic, copy) NSString *statusName;//
@property (nonatomic, copy) NSString *patriarchName;//
@property (nonatomic, copy) NSString *address;//
@property (nonatomic, copy) NSString *sex;//
@property (nonatomic, copy) NSString *age;//
@property (nonatomic, copy) NSString *nickName;//
@property (nonatomic, copy) NSString *headPortrait;//

+ (PatriarchModel *)initWithDic:(NSDictionary *)dic;

@end
