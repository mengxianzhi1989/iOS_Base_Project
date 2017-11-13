//
//  MUser.m
//  NetWork
//
//  Created by mengxianzhi on 16/8/30.
//  Copyright © 2016年 mengxianzhi. All rights reserved.
//

#import "MUser.h"

@implementation MStoreRoleModel
@synthesize roleId;
@synthesize roleName;
@synthesize storeName;
@synthesize storeId;

@end


@implementation MUserData
@synthesize telephone;
@synthesize name;

-(NSDictionary *)replacedKeyFromPropertyName {
    return @{@"_id" : @"id"};
}
- (NSDictionary *)objectClassInArray{
    return @{@"storeRoleMap":[MStoreRoleModel class]};
}

@end

@implementation MUser
@synthesize data;

//- (NSDictionary *)objectClassInArray{
//    return @{@"data":[MUserData class]};
//}

@end
