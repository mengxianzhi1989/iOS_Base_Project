//
//  QFHttpUrl.m
//  QFen
//
//  Created by TDJR on 16/3/24.
//  Copyright © 2016年 KFG. All rights reserved.
//

#import "QFHttpUrl.h"

//test
#define kBaseUrl @"http://www.huowangtong.com"
//#define kBaseUrl @"http://192.168.49.50:9080/"



static QFHttpUrl *sharedHttpUrl = nil;
@implementation QFHttpUrl

//单例初始化对象
+(QFHttpUrl *)sharedHttpUrl {
    @synchronized(self) {
        if (sharedHttpUrl == nil) {
            sharedHttpUrl = [[super allocWithZone:NULL] init];
        }
    }
    
    return sharedHttpUrl;
}

-(id)init {
    @synchronized(self) {
        if (sharedHttpUrl == nil) {
            sharedHttpUrl = [super init];
            if (self) {
                
            }
        }
    }
    
    return sharedHttpUrl;
}

+(id)allocWithZone:(NSZone*)zone {
    return [QFHttpUrl sharedHttpUrl];
}

-(id)copyWithZone:(NSZone *)zone {
    return sharedHttpUrl;
}

#pragma -mark function
-(NSString *)hostName:(NSString *)urlStr {
    return [urlStr componentsSeparatedByString:@"://"].lastObject;
}

-(BOOL)httpHeader:(NSString *)urlStr {
    NSString *httpH = [urlStr componentsSeparatedByString:@"://"].firstObject;
    return [httpH isEqualToString:@"https"];
}

-(NSString *)defaulthostName {
    return [[QFHttpUrl sharedHttpUrl] hostName:self.getBaseUrl];
}

-(BOOL)defaulthttpHeader {
    return [[QFHttpUrl sharedHttpUrl] httpHeader:self.getBaseUrl];
}

- (NSString *)getBaseUrl{
#ifdef TestBug
    NSString *url=[USER_DEFAULTS objectForKey:@"environment_Url"];
    NSString *URL =  url.length > 0 ? url:kBaseUrl;
    return URL;
#else
    return kBaseUrl;
#endif
    
}

-(NSString *)urlOfRequestId:(RequestType)aId {
    NSMutableString *strTmp = [[NSMutableString alloc] init];
    switch (aId) {
        case Getbycondition:
        {
            [strTmp appendFormat:@"%@",@"/info/cargoInfo/querybycondition.shtml"];
        }
            break;
        case UserLoginType:
        {
            [strTmp appendFormat:@"%@",@"/login_check"];
        }
            break;
        case CarSourceSave:
        {
            [strTmp appendFormat:@"%@",@"/customer/listSaleByStoreId"];
        }
            break;
        default:
            break;
    }
    return [NSString stringWithString:strTmp];
}


@end
