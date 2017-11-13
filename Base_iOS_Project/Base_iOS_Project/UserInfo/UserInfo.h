//
//  UserInfo.h
//  Car-league
//
//  Created by TDJR on 16/5/26.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserInfo : NSObject <NSCoding>

@property (nonatomic, strong) NSString  *email;
@property (nonatomic, strong) NSString  *ID;
@property (nonatomic, strong) NSString  *imgPath;
@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *qq;
@property (nonatomic, strong) NSString  *roleId;
@property (nonatomic, strong) NSString  *roleLabel;
@property (nonatomic, strong) NSString  *sex;
@property (nonatomic, strong) NSString  *storeNameLabel;
@property (nonatomic, strong) NSString  *telephone;
@property (nonatomic, strong) NSString  *token;

//单例初始化对象
+ (UserInfo *)sharedUserInfo;
//清空数据
- (void)clearnData;


@end
