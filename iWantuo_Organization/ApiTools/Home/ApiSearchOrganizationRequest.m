//
//  ApiSearchOrganizationRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/19.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiSearchOrganizationRequest.h"

@implementation ApiSearchOrganizationRequest

- (NSString *)urlAction {
    return SearchOrganizationListAction;
}

-(void)setApiParamsWithLocation:(NSString *)location
                         bairro:(NSString *)bairro
                   organization:(NSString *)organization
                           page:(NSString *)page
                      locationX:(NSString *)locationX
                      locationY:(NSString *)locationY
                       distance:(NSString *)distance
                           Type:(NSString *)Type
                           rows:(NSString *)rows{
    [self.params setValue:location forKey:@"location"];
    [self.params setValue:bairro forKey:@"bairro"];
    [self.params setValue:organization forKey:@"organization"];
    [self.params setValue:page forKey:@"page"];
    [self.params setValue:rows forKey:@"rows"];
    [self.params setValue:locationX forKey:@"x"];
    [self.params setValue:locationY forKey:@"y"];
    [self.params setValue:distance forKey:@"distance"];
    [self.params setValue:Type forKey:@"Type"];//1 附近查询 2 星级查询  3 排行榜
}


@end
