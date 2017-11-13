//
//  QFHttpUrl.h
//  QFen
//
//  Created by TDJR on 16/3/24.
//  Copyright © 2016年 KFG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFHttpUrl : NSObject

//单列
+(QFHttpUrl *)sharedHttpUrl;

-(NSString *)hostName:(NSString *)urlStr;
-(BOOL)httpHeader:(NSString *)urlStr;
-(NSString *)defaulthostName;
-(BOOL)defaulthttpHeader;
- (NSString *)getBaseUrl;
-(NSString *)urlOfRequestId:(RequestType)aId;

@end
