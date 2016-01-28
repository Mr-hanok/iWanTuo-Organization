//
//  ApiChangeArganization.h
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "APIRequest.h"
/**
 *  修改机构信息
 */
@interface ApiChangeArganization : APIRequest
/**
 *  修改机构信息
 *
 *  @param loginAccounts        登录帐号
 *  @param location             所在地id
 *  @param locationName         所在地
 *  @param bairro               所在区id
 *  @param bairroName           所在区
 *  @param address              详细地址
 *  @param organizatioType      机构类型
 *  @param organizatioTypeName  机构类型名称
 *  @param organization         机构全称
 *  @param phone                phone
 *  @param introduce            介绍
 *  @param label                标签
 *  @param photoAlbum           效果图
 *  @param cost                 价格
 */
- (void)setApiParamsWithLoginAccounts:(NSString *)loginAccounts
                             location:(NSString *)location
                         locationName:(NSString *)locationName
                               bairro:(NSString *)bairro
                           bairroName:(NSString *)bairroName
                              address:(NSString *)address
                      organizatioType:(NSString *)organizatioType
                  organizatioTypeName:(NSString *)organizatioTypeName
                         organization:(NSString *)organization
                                phone:(NSString *)phone
                            introduce:(NSString *)introduce
                                label:(NSString *)label
                           photoAlbum:(NSString *)photoAlbum
                                 cost:(NSString *)cost;
@end
