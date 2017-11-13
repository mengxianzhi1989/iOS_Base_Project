//
//  UserInfo.m
//  Car-league
//
//  Created by TDJR on 16/5/26.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "UserInfo.h"
#import "UserInfoTool.h"



@implementation UserInfo
@synthesize email;
@synthesize ID;
@synthesize imgPath;
@synthesize name;
@synthesize qq;
@synthesize roleId;
@synthesize roleLabel;
@synthesize sex;
@synthesize storeNameLabel;
@synthesize telephone;
@synthesize token;


static UserInfo *sharedInstanceUserInfo = nil;

//单例初始化对象
+ (UserInfo *)sharedUserInfo {
    @synchronized(self) {
        if (sharedInstanceUserInfo == nil) {
            sharedInstanceUserInfo = [[super allocWithZone:NULL] init];
        }
    }
    return sharedInstanceUserInfo;
}

- (id)init {
    @synchronized(self) {
        if (sharedInstanceUserInfo == nil) {
            sharedInstanceUserInfo = [super init];
            if (self) {
                sharedInstanceUserInfo.email = @"";
                sharedInstanceUserInfo.ID = @"";
                sharedInstanceUserInfo.imgPath = @"";
                sharedInstanceUserInfo.name = @"";
                sharedInstanceUserInfo.qq = @"";
                sharedInstanceUserInfo.roleId = @"";
                sharedInstanceUserInfo.roleLabel = @"";
                sharedInstanceUserInfo.sex = @"";
                sharedInstanceUserInfo.storeNameLabel = @"";
                sharedInstanceUserInfo.telephone = @"";
                sharedInstanceUserInfo.token = @"";
            }
            [sharedInstanceUserInfo readData];
        }
    }
    return sharedInstanceUserInfo;
}

+ (id)allocWithZone:(NSZone*)zone {
    return [UserInfo sharedUserInfo];
}

- (id)copyWithZone:(NSZone *)zone {
    return sharedInstanceUserInfo;
}

- (void)readData {
    UserInfo *tmpObj = [UserInfoTool readUserInfoModel];
    if (tmpObj) {
        sharedInstanceUserInfo = tmpObj;
    }
}

//清空数据
- (void)clearnData {
    sharedInstanceUserInfo.email = @"";
    sharedInstanceUserInfo.ID = @"";
    sharedInstanceUserInfo.imgPath = @"";
    sharedInstanceUserInfo.name = @"";
    sharedInstanceUserInfo.qq = @"";
    sharedInstanceUserInfo.roleId = @"";
    sharedInstanceUserInfo.roleLabel = @"";
    sharedInstanceUserInfo.sex = @"";
    sharedInstanceUserInfo.storeNameLabel = @"";
    sharedInstanceUserInfo.telephone = @"";
    sharedInstanceUserInfo.token = @"";
    
    [UserInfoTool deleteUserInfoModel];
}

- (NSString *)setObjModel:(id)aObj {
    if (aObj && [aObj isKindOfClass:[NSString class]] && [aObj length] > 0) {
        return aObj;
    }
    
    return @"";
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([sharedInstanceUserInfo class], &count);
        for (NSInteger i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char *parmaName = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:parmaName];
            id value = [aDecoder decodeObjectForKey:key];
            [sharedInstanceUserInfo setValue:value forKey:key];
        }
        free(ivars);
    }
    
    return sharedInstanceUserInfo;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (NSInteger i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *parmaName = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:parmaName];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

@end
