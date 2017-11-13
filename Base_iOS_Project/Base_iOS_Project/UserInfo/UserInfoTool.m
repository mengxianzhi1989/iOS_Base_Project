//
//  UserInfoTool.m
//  Car-league
//
//  Created by TDJR on 16/5/26.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "UserInfoTool.h"

#define kFileName @"CaruserInfo.data"
#define kPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName]

@implementation UserInfoTool

+(void)saveUserInfoModel:(UserInfo *)model {
    if(model) {
        [NSKeyedArchiver archiveRootObject:model toFile:kPath];
    }
}

+(UserInfo *)readUserInfoModel {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kPath];
}

+(void)deleteUserInfoModel {
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:kPath]){
        [manager removeItemAtPath:kPath error:nil];
    }
}

+ (BOOL)userIsLogin {
    UserInfo *user = [UserInfo sharedUserInfo];
    if (user && user.token.length > 0) {
        return YES;
    }else {
        return NO;
    }
}
@end
