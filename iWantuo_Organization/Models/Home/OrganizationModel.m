//
//  OrganizationModel.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "OrganizationModel.h"

@implementation OrganizationModel



+ (OrganizationModel *)initWithDic:(NSDictionary *)dic {
    
    OrganizationModel *model = [[OrganizationModel alloc] init];
    
    model.organizationId = [ValueUtils stringFromObject:[dic objectForKey:@"id"]];
    model.location = [ValueUtils stringFromObject:[dic objectForKey:@"location"]];
    model.locationName = [ValueUtils stringFromObject:[dic objectForKey:@"locationName"]];
    model.bairro = [ValueUtils stringFromObject:[dic objectForKey:@"bairro"]];
    model.bairroName = [ValueUtils stringFromObject:[dic objectForKey:@"bairroName"]];
    model.address = [ValueUtils stringFromObject:[dic objectForKey:@"address"]];
    model.loginAccounts = [ValueUtils stringFromObject:[dic objectForKey:@"loginAccounts"]];
    model.email = [ValueUtils stringFromObject:[dic objectForKey:@"email"]];
    model.organizatioType = [ValueUtils stringFromObject:[dic objectForKey:@"organizatioType"]];
    model.organizatioTypeName = [ValueUtils stringFromObject:[dic objectForKey:@"organizatioTypeName"]];
    model.organizationAbbreviation = [ValueUtils stringFromObject:[dic objectForKey:@"organizationAbbreviation"]];
    model.organization = [ValueUtils stringFromObject:[dic objectForKey:@"organization"]];
    model.organizationContacts = [ValueUtils stringFromObject:[dic objectForKey:@"organizationContacts"]];
    model.idCardImage = [ValueUtils stringFromObject:[dic objectForKey:@"idCardImage"]];
    model.businessLicenseImage = [ValueUtils stringFromObject:[dic objectForKey:@"businessLicenseImage"]];
    model.coordinateX = [ValueUtils stringFromObject:[dic objectForKey:@"coordinateX"]];
    model.coordinateY = [ValueUtils stringFromObject:[dic objectForKey:@"coordinateY"]];
    model.phone = [ValueUtils stringFromObject:[dic objectForKey:@"phone"]];
    model.idCard = [ValueUtils stringFromObject:[dic objectForKey:@"idCard"]];
    model.businessLicense = [ValueUtils stringFromObject:[dic objectForKey:@"businessLicense"]];
    model.createDate = [ValueUtils stringFromObject:[dic objectForKey:@"createDate"]];
    model.updateDate = [ValueUtils stringFromObject:[dic objectForKey:@"updateDate"]];
    model.check = [ValueUtils stringFromObject:[dic objectForKey:@"check"]];
    model.checkName = [ValueUtils stringFromObject:[dic objectForKey:@"checkName"]];
    model.attestation = [ValueUtils stringFromObject:[dic objectForKey:@"attestation"]];
    model.attestationName = [ValueUtils stringFromObject:[dic objectForKey:@"attestationName"]];
    model.warranty = [ValueUtils stringFromObject:[dic objectForKey:@"warranty"]];
    model.warrantyName = [ValueUtils stringFromObject:[dic objectForKey:@"warrantyName"]];
    model.introduce = [ValueUtils stringFromObject:[dic objectForKey:@"introduce"]];
    model.label = [ValueUtils stringFromObject:[dic objectForKey:@"label"]];
    model.photoAlbum = [ValueUtils stringFromObject:[dic objectForKey:@"photoAlbum"]];
    model.cost = [ValueUtils stringFromObject:[dic objectForKey:@"cost"]];
    model.orderNum = [ValueUtils stringFromObject:[dic objectForKey:@"orderNum"]];
    model.evaluate = [ValueUtils stringFromObject:[dic objectForKey:@"evaluate"]];
    model.evaluateNum = [ValueUtils stringFromObject:[dic objectForKey:@"evaluateNum"]];
    model.subject = [ValueUtils stringFromObject:[dic objectForKey:@"subject"]];
    model.teacher = [ValueUtils stringFromObject:[dic objectForKey:@"teacher"]];
    model.headPortrait = [ValueUtils stringFromObject:[dic objectForKey:@"headPortrait"]];
    model.distance = [ValueUtils stringFromObject:[dic objectForKey:@"distance"]];
    
    return model;
}

@end
