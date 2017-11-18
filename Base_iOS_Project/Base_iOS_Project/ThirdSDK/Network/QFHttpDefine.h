//
//  QFHttpDefine.h
//  QFen
//
//  Created by TDJR on 16/3/24.
//  Copyright © 2016年 KFG. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef QFHttpDefine_h
#define QFHttpDefine_h

#define kHTTP_POST @"POST"
#define kHTTP_GET  @"GET"

#define HTTP_TIMEOUT_NUM 30

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestType_None = 0,
    Getbycondition,
    UserLoginType,
    NewsLatest,
    Querybycondition

};

#endif
