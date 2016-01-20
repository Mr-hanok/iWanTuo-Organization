//
//  ApiRegisterRequest.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiRegisterRequest.h"

@implementation ApiRegisterRequest

- (ApiAccessType)accessType
{
    return kApiAccessPost;
}
- (NSString *)serviceUrl {
    return SERVER_HOST_PRODUCT;
}
- (NSString *)urlAction {
    return RegisterOganiza;
}

-(void)setApiParamsWithLoginAccount:(NSString *)loginAccounts
                           password:(NSString *)password
                            address:(NSString *)address
                              email:(NSString *)email
           organizationAbbreviation:(NSString *)organizationAbbreviation
                       organization:(NSString *)organization
               organizationContacts:(NSString *)organizationContacts
                        locationName:(NSString *)locationName
                           location:(NSString *)location
                             bairro:(NSString *)bairro
                         bairroName:(NSString *)bairroName
{
    
    [self.params setValue:loginAccounts forKey:@"loginAccounts"];
    
    [self.params setValue:password  forKey:@"password"];
    [self.params setValue:organizationAbbreviation forKey:@"organizationAbbreviation"];
    [self.params setValue:organization forKey:@"organization"];
    [self.params setValue:organizationContacts forKey:@"organizationContacts"];
    [self.params setValue:email forKey:@"email"];
    [self.params setValue:address forKey:@"address"];
    [self.params setValue:locationName forKey:@"locationName"];
    [self.params setValue:location forKey:@"location"];
    [self.params setValue:bairro forKey:@"bairro"];
    [self.params setValue:bairroName forKey:@"bairroName"];

    
}

@end
