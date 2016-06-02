//
//  SharSdkManager.m
//  StudyChina
//
//  Created by 月 吴 on 15/10/27.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import "SharSdkManager.h"
//第三方平台的SDK头文件，根据需要的平台导入。
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "WXApi.h"
//#import "WeiboSDK.h"
//使用举例
//[SharSdkManager ShareEventClicked:self.view content:@"分享啊" url:@"http://www.baidu.com" imageUrl:@"http://t11.baidu.com/it/u=1097677432,1412399127&fm=76"];

@implementation SharSdkManager


//触发分享的事件
+ (void)ShareEventClicked:(UIView *)view content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl
{
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"爱晚托分享"
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:content
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
    //1、构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@", content]
//                                       defaultContent:@"分享"
//                                                image:[ShareSDK imageWithUrl:imageUrl]
//                                                title:content
//                                                  url:url
//                                          description:@"学习型中国公众号内容"
//                                            mediaType:SSPublishContentMediaTypeNews];
//    //1+创建弹出菜单容器（iPad必要）
//    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:view arrowDirect:UIPopoverArrowDirectionUp];
//    
//    //2、弹出分享菜单
//    [ShareSDK showShareActionSheet:container
//                         shareList:nil
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions:nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                
//                                //可以根据回调提示用户。
//                                if (state == SSResponseStateSuccess)
//                                {
//                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                    message:nil
//                                                                                   delegate:self
//                                                                          cancelButtonTitle:@"OK"
//                                                                          otherButtonTitles:nil, nil];
//                                    [alert show];
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
//                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                                    message:[NSString stringWithFormat:@"失败描述：%@",[error errorDescription]]
//                                                                                   delegate:self
//                                                                          cancelButtonTitle:@"OK"
//                                                                          otherButtonTitles:nil, nil];
//                                    [alert show];
//                                }
//                            }];
}

@end
