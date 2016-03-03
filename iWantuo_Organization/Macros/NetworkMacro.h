//
//  NetworkMacro.h
//  StudyChina
//
//  Created by 陈腾飞 on 15/9/8.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#ifndef StudyChina_NetworkMacro_h
#define StudyChina_NetworkMacro_h
#import "MineNetWork.h"

//#define SERVER_HOST_PRODUCT             @"http://192.168.1.169:8090/wantuo/"           // 内网地址
//#define SERVER_HOST_PRODUCT             @"http://192.168.1.107:8080/wantuo/"           // 外网地址
#define SERVER_HOST_PRODUCT             @"http://www.iwantuo.com/wantuo/"           // 外网地址
#define SERVER_FILE_PRODUCT             @"http://img.yilingboshi.com/"              // 图片服务器地址

#define SDKKey_Msg                  @"msg"
#define SDKKey_Status               @"status"

#define kDefaultServerErrorString               @"服务器异常，请稍后再试"
#define kDefaultNetWorkErrorString              @"网络连接异常"
#define kDefaultQuitErrorString                 @"您的账号已经在别处登录!"
#define kDefaultWebErrorString                  @"抱歉,此网页出现了问题"

#pragma mark - 请求地址

#define kRequestKey                         @"THINKSNS"

#define kRequestTokenAction                 @"index.php?app=api&mod=Oauth&act=authorize"    // 获取用户token

#define LoginSucessedNotification   @"LoginSucessedNotification"
#define LoginOutNotification        @"LoginOutNotification"
#define kRequestDataRows  @"15"


#define LoginAction                 @"login/phoneOzAndTeacherLogin"  // 登录接口
#define LoginQuitAction             @"login/phoneOutLogin"              // 退出登录接口
#define FindPassword                @"login/phoneFindPassword"  //找回密码
#define RegisterOganiza             @"register/phoneOganizationRegister"//机构注册
#define SendPhoneMessage            @"SendSMS/phoneSendSMSToRegister"//发送验证码注册
#define SendPhoneMessageToFind      @"SendSMS/phoneSendSMSToFind"//发送验证码找回密码
#define UploadImageApi              @"FileUpload/phoneFilesUpload"//上传图片头像
#define CityAreaList                @"syscode/phoneQueryByList"//城市地区列表



//my
#define SaveStudentAction            @"student/phoneStudentSave" //添加学生
#define PatriarchListAction          @"Patriarch/phoneQueryByList" //搜索家长信息列表
#define TeacherListAction            @"teacher/phoneQueryByList" //获取取机构下的班主任
#define AddTeacherAction             @"register/phoneRegisterTeacher" //添加班主任
#define EditTeacherAction             @"teacher/phoneUpdateTeacher" //修改班主任
#define StudentByClassAction         @"studentClass/phoneSelect" //查询班级下学生
#define AddClassAction               @"class/phoneSave" //添加班级
#define ClassListAction              @"class/phoneSelect" //获取机构下的班级
#define DeleteClassAction            @"class/phoneDelete"//删除班级
#define StudentByOrgAndClassAction   @"studentClass/phoneSelectNoStudent" //获取班级下未添加的学生
#define StudentListByOrgAction       @"studentSchool/phoneStudentList" //获取机构下的学生
#define SaveStudentsByClassAction    @"studentClass/phoneSaveList" //批量保存学员与班级关系
#define DeleteStudentsByClassAction  @"studentClass/phoneDeleteList" //批量删除学员与班级关系
#define DeleteTeacherAction          @"teacher/phoneDelete" //删除老师
#define DeleteStudentByOrgAction     @"studentSchool/phoneDeleteStudentSchool" //删除机构下的学员
#define GetStudentInfoAction         @"student/phoneGetById" //获取学生信息
#define UpdateStudentInfoAction      @"student/phoneStudentUpdate" //修改学生信息


#define FollowAddRequest          @"trace/phoneSave" //追踪增加接口
#define FollowCheckRequest        @"trace/phoneGetById" //追踪查询接口
#define FollowChangeRequest       @"trace/phoneUpdate" //追踪修改接口
#define SyscodePhoneQueryByList   @"syscode/phoneQueryByList" //学科查询接口
#define OrganizationPhoneUpdate   @"organization/phoneUpdate" //机构修改接口
#define OrganizationPhoneGetById   @"organization/phoneGetById" //获取机构信息接口
//home
#define SearchSchoolListAction       @"school/phoneQueryByList"
#define SearchOrganizationListAction @"organization/phoneQueryByList"
#define CityListAction               @"syscode/phoneQueryByList"
#define OrganizationDetailAction     @"organization/phoneGetById"
#define AddBookAction                @"organization/phoneUpdateOrder"
#define CancelAttentionOrgAction     @"collect/phoneDelete"
#define AttentionOrgAction           @"collect/phoneSave" //收藏机构
#define SubmitCommentAction          @"evaluate/phoneAddEvaluate"
#define CommentListAction            @"evaluate/phoneEvaluateList"
#define MyCollectionAction           @"collect/phoneQueryByList"
#define GrowCurveAction              @"trace/phoneSelectShow"
#define MyChildAction                @"student/phoneSelect"//获取我的小孩
#define FollowCheckRequest           @"trace/phoneGetById" //每日表现查询接口

//top
#define TopActiveAction                 @"activity/phoneQueryList" //广场活动接口

#endif
