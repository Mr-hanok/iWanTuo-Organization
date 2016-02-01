//
//  OrganizationListViewController.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    OriginSchool,
    OriginAddress,
    OriginOrganization,
    OriginSort
} OriginType;

@interface OrganizationListViewController : BaseViewController

@property (nonatomic, copy) NSString *locationX;
@property (nonatomic, copy) NSString *locationY;
@property (nonatomic, assign) OriginType originType;
@property (nonatomic, copy) NSString *searchKey;

#pragma mark - public
/**
 *  通过学校查找学校周边的机构
 *
 *  @param locationX
 *  @param locationY
 *  @param nav
 */
+ (void)showOrganizationListBySchoolWithLocationX:(NSString *) locationX locationY:(NSString *)locationY nav:(UINavigationController *)nav;
/**
 *  通过地址周边的机构
 *
 *  @param locationX
 *  @param locationY
 *  @param nav
 */
+ (void)showOrganizationListByAddressWithLocationX:(NSString *) locationX locationY:(NSString *)locationY nav:(UINavigationController *)nav;

/**
 *  通过关键字搜索的机构
 *
 *  @param searchKey
 *  @param nav       
 */
+ (void)showOrganizationListBySearchKey:(NSString *) searchKey nav:(UINavigationController *)nav;
@end
