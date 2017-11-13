//
//  UserInfoTool.h
//  Car-league
//
//  Created by TDJR on 16/5/26.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;

@interface UserInfoTool : NSObject

+(void)saveUserInfoModel:(UserInfo *)model;
+(UserInfo *)readUserInfoModel;
+(void)deleteUserInfoModel;
//当前用户是否登录
+ (BOOL)userIsLogin;

@end
