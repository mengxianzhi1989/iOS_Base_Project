//
//  QFNetWorkManger.h
//  QFen
//
//  Created by TDJR on 16/3/24.
//  Copyright © 2016年 KFG. All rights reserved.
//




typedef void (^ResponseCallback)(NSDictionary * responseDictionary, NSError * error);

typedef void (^ResponseCallbackIndex)(NSDictionary * responseDictionary, NSError * error,int indexId);

@interface QFNetWorkManger : NSObject

+ (void)request:(RequestType)requestType withView:(UIView*)aView withAnimated:(BOOL)aFlag withParameters:(NSDictionary *)parameters httpMethod:(NSString*) httpMethod responseCallBack:(ResponseCallback)responseCallBack;

+ (void)upload:(RequestType)requestType withParameters:(NSDictionary *)parameters imageData:(NSMutableArray *)imageData httpMethod:(NSString*) httpMethod indexId:(int)indexId responseCallBack:(ResponseCallbackIndex)responseCallBack;

@end

