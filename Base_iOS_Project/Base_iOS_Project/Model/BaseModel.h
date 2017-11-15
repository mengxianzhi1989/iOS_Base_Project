//
//  BaseModel.h
//  Car-league
//
//  Created by TDJR on 16/5/26.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

@interface BaseModel : NSObject

//网络请求状态标示码
@property (assign, nonatomic) NSInteger status;
@property (assign, nonatomic) NSInteger errcode;
//网络请求状态内容
@property (strong, nonatomic) NSString* msg;

@end
