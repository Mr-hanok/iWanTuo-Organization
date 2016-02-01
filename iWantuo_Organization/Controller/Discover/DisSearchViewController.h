//
//  DisSearchViewController.h
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/26.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^BackBlock)(CLLocationCoordinate2D coordinate, NSString *address);
@interface DisSearchViewController : BaseViewController
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, copy) BackBlock backBlock;
@end
