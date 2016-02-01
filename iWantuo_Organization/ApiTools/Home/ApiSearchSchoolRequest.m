//
//  ApiSearchSchoolRequest.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/18.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "ApiSearchSchoolRequest.h"

@implementation ApiSearchSchoolRequest


- (NSString *)urlAction {
    return SearchSchoolListAction;
}

-(void)setApiParamsWithLocation:(NSString *)location schoolName:(NSString *)schoolName page:(NSString *)page locationX:(NSString *)locationX locationY:(NSString *)locationY{
    [self.params setValue:location forKey:@"location"];
    [self.params setValue:schoolName forKey:@"schoolName"];
    [self.params setValue:page forKey:@"page"];
    [self.params setValue:kRequestDataRows forKey:@"rows"];
    [self.params setValue:locationX forKey:@"x"];
    [self.params setValue:locationY forKey:@"y"];
}

@end
