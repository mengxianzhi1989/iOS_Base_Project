//
//  QFNetWorkManger.m
//  QFen
//
//  Created by TDJR on 16/3/24.
//  Copyright © 2016年 KFG. All rights reserved.
//

#import "QFNetWorkManger.h"
#import "MBProgressHUD.h"
#import "QFHttpUrl.h"
#import "MKNetworkHost.h"

@interface QFNetWorkManger()

@end

@implementation QFNetWorkManger

+ (void)request:(RequestType)requestType withView:(UIView*)aView withAnimated:(BOOL)aFlag withParameters:(NSDictionary *)parameters httpMethod:(NSString*) httpMethod responseCallBack:(ResponseCallback)responseCallBack {

    
    QFHttpUrl *httpUrl = [QFHttpUrl sharedHttpUrl];
    NSString *hostName = [httpUrl defaulthostName];
    MKNetworkHost *host = [[MKNetworkHost alloc]initWithHostName:hostName];
    host.secureHost = [httpUrl defaulthttpHeader];
    MKNetworkRequest *mkrequest = [host requestWithPath:[httpUrl urlOfRequestId:requestType] params:[self appendBaseParamas:parameters] httpMethod:httpMethod];
    MBProgressHUD *hud;
    if (aView) {
        hud = [MBProgressHUD showHUDAddedTo:aView animated:aFlag];
        if (CGRectGetHeight(aView.frame) == kScreenHeight) {
            //假设aView高度为屏高VC view去除StatusBarAndNavBarHeight 自定义aView非VC.view为屏幕高度除外
            hud.frame = CGRectMake(0, KStatusBarAndNavBarHeight, CGRectGetWidth(aView.frame), CGRectGetHeight(aView.frame));
        }
    }
//    UserInfo *user = [UserInfo sharedUserInfo];
//    if ([user.token length] > 0) {
//        //添加请求头信息
//        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithCapacity:4];
//        [tmpDic setObject:@"application/x-www-form-urlencoded; charset=UTF-8" forKey:@"Content-Type"];
//        [tmpDic setObject:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36" forKey:@"User-Agent"];
//        [mkrequest addHeaders:tmpDic];
//    }
    
    if (requestType == CarSourceSave) {
        mkrequest.parameterEncoding = MKNKParameterEncodingJSON;
    }
    
    [mkrequest addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        [hud hideAnimated:YES];
        if(completedRequest.state == MKNKRequestStateCompleted) {
            
            NSError *error = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:completedRequest.responseData options:NSJSONReadingMutableContainers error:&error];
            if(error == nil) {
                responseCallBack(dict,nil);
            }else {
                responseCallBack(nil,error);
            }
        }else {
            responseCallBack(nil,completedRequest.error);
        }
    }];
    [host startRequest:mkrequest];
}

+ (void)upload:(RequestType)requestType withParameters:(NSDictionary *)parameters imageData:(NSMutableArray *)imageData httpMethod:(NSString*) httpMethod indexId:(int)indexId responseCallBack:(ResponseCallbackIndex)responseCallBack {
    QFHttpUrl *httpUrl = [QFHttpUrl sharedHttpUrl];
    NSString *hostName = [httpUrl defaulthostName];
    MKNetworkHost *host = [[MKNetworkHost alloc]initWithHostName:hostName];
    host.secureHost = [httpUrl defaulthttpHeader];
    NSData *boydata = [self httpBodyData:imageData paramas:[self appendBaseParamas:parameters]];
    MKNetworkRequest *mkrequest = [host requestWithPath:[httpUrl urlOfRequestId:requestType] params:nil httpMethod:httpMethod body:boydata ssl:host.secureHost];
    [mkrequest addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        if(completedRequest.state == MKNKRequestStateCompleted) {
            NSError *error = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:completedRequest.responseData options:NSJSONReadingMutableLeaves error:&error];
            if(error == nil) {
                responseCallBack(dict,nil,indexId);
            }else {
                responseCallBack(nil,error,indexId);
            }
        }else {
            responseCallBack(nil,completedRequest.error,indexId);
        }
    }];
    [host startRequest:mkrequest];
}

+ (NSDictionary *)appendBaseParamas:(NSDictionary *)params {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
    return dict;
}

+ (NSData *)httpBodyData:(NSMutableArray *)imagedata paramas:(NSDictionary *)dict {
    NSMutableData *formData = [NSMutableData data];
    NSString *Boundary = @"----WebKitFormBoundary9vcoU0HtSGBV9xTT";
    NSString *myBoundary = [[NSString alloc] initWithFormat:@"--%@",Boundary];
    NSString *endmyBoundary = [[NSString alloc] initWithFormat:@"%@--",myBoundary];
    NSMutableString *paramBody = [[NSMutableString alloc]init];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [paramBody appendFormat:@"%@\r\n",myBoundary];
        [paramBody appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        [paramBody appendFormat:@"%@\r\n",obj];
    }];
    [paramBody appendFormat:@"%@\r\n",myBoundary];
    [formData appendData:[paramBody dataUsingEncoding:NSUTF8StringEncoding]];
    [imagedata enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *thisDataObject = (NSDictionary*) obj;
        NSString *imageKey=thisDataObject.allKeys.firstObject;
        NSMutableString *imageBody = [[NSMutableString alloc] init];
        [imageBody appendFormat:@"%@\r\n",myBoundary];
        [imageBody appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",imageKey ,[NSString stringWithFormat:@"%@.png",imageKey]];
        [imageBody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
        [formData appendData:[paramBody dataUsingEncoding:NSUTF8StringEncoding]];
        [formData appendData:[imageBody dataUsingEncoding:NSUTF8StringEncoding]];
        [formData appendData:UIImageJPEGRepresentation(thisDataObject[imageKey], 0.1)];
        [formData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    NSString *end = [[NSString alloc]initWithFormat:@"%@\r\n",endmyBoundary];
    [formData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    return formData;
}

- (void)dealloc {
    
}

@end
