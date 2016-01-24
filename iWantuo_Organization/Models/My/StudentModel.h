//
//  StudentModel.h
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/23.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentModel : NSObject

@property (nonatomic, copy) NSString *Id;//
@property (nonatomic, copy) NSString *studentId;//
@property (nonatomic, copy) NSString *classId;//
@property (nonatomic, copy) NSString *name;//

+ (StudentModel *)initWithDic:(NSDictionary *)dic;

@end
