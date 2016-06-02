//
//  MyStudentViewController.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "BaseViewController.h"
#import "StudentModel.h"

typedef enum : NSUInteger {
    AddInfoType,
    UpdateInfoType,
} InfoType;
/**
 *  添加学员
 */
@interface MyStudentViewController : BaseViewController

@property (nonatomic, strong) NSString *studentId;

@property (nonatomic, assign) InfoType infoType;

@end
