//
//  ApiChangeArganization.m
//  iWantuo_Organization
//
//  Created by yuntai on 16/1/27.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiChangeArganization.h"

@implementation ApiChangeArganization
- (NSString *)urlAction {
    return OrganizationPhoneUpdate;
}
- (ApiAccessType)accessType
{
    return kApiAccessPost;
}

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
                                 cost:(NSString *)cost{
    
    [self.params setValue:loginAccounts forKey:@"loginAccounts"];
    [self.params setValue:location forKey:@"location"];
    [self.params setValue:locationName forKey:@"locationName"];
    [self.params setValue:bairro forKey:@"bairro"];
    [self.params setValue:bairroName forKey:@"bairroName"];
    [self.params setValue:address forKey:@"address"];
    [self.params setValue:organizatioType forKey:@"organizatioType"];
    [self.params setValue:organizatioTypeName forKey:@"organizatioTypeName"];
    [self.params setValue:organization forKey:@"organization"];
    [self.params setValue:phone forKey:@"phone"];
    [self.params setValue:introduce forKey:@"introduce"];
    [self.params setValue:label forKey:@"label"];
    [self.params setValue:photoAlbum forKey:@"photoAlbum"];
    [self.params setValue:cost forKey:@"cost"];
    
}

@end
