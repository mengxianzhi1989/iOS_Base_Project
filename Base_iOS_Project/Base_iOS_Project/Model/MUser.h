//
//  MUser.h
//  NetWork
//
//  Created by mengxianzhi on 16/8/30.
//  Copyright © 2016年 mengxianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface MStoreRoleModel : NSObject
@property (strong,nonatomic) NSString *roleId;
@property (strong,nonatomic) NSString *roleName;
@property (strong,nonatomic) NSString *storeName;
@property (strong,nonatomic) NSString *storeId;
@end

@interface MUserData : NSObject
@property (strong,nonatomic) NSString *_id;
@property (strong,nonatomic) NSString *telephone;
@property (strong,nonatomic) NSString *name;

@property (strong,nonatomic) NSArray *storeRoleMap;
@end

@interface MUser : BaseModel
@property (strong,nonatomic) MUserData *data;
@end
