//
//  UIImage+Video.h
//  StudyChina
//
//  Created by 月 吴 on 15/10/26.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface UIImage (Video)
+(UIImage *)getImage:(NSString *)videoURL;
@end
