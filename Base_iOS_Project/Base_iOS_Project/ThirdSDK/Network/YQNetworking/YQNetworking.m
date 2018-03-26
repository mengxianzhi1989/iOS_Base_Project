//
//  YQNetworking.m
//  YQNetworking
//
//  Created by yingqiu huang on 2017/2/10.
//  Copyright © 2017年 yingqiu huang. All rights reserved.
//
#define kRefeshTokenExpiredCode 10001
#define kQequestTimeout         -1001
#define kAccountRemove          10040

#import "YQNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "YQCacheManager.h"

static NSMutableArray *requestTasksPool;
static NSMutableDictionary *headers;
static NSTimeInterval  requestTimeout = 40.f;

static BOOL isShowingAlertView = NO;
static BOOL isShowingNo_NetWork_AlertView = NO;

@interface YQNetworking()

@end

@implementation YQNetworking

+ (void)load{
    headers = [NSMutableDictionary dictionary];
}
static  AFHTTPSessionManager *manager = nil;
#pragma mark - manager
+ (AFHTTPSessionManager *)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        manager = [AFHTTPSessionManager manager];
    });
    //默认解析模式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    //配置响应序列化
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*",@"application/octet-stream",@"application/zip"]];
    for (NSString *key in headers.allKeys) {
        if (headers[key] != nil) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    //每次网络请求的时候，检查此时磁盘中的缓存大小，阈值默认是40MB，如果超过阈值，则清理LRU缓存,同时也会清理过期缓存，缓存默认SSL是7天，磁盘缓存的大小和SSL的设置可以通过该方法[YQCacheManager shareManager] setCacheTime: diskCapacity:]设置
    [[YQCacheManager shareManager] clearLRUCache];
    
    return manager;
}

+ (void)postWithRequestType:(RequestType)requestType withView:(UIView *)aView
                     params:(id)params tipMsg:(NSString *)tipMsg
                finishBlock:(YQResponseSuccessBlock)finishBlock
                  failBlock:(YQResponseFailBlock)failBlock{
    if(![[AppDelegate getAppDelegate] connection]) {
        if(![[AppDelegate getAppDelegate] connection]) {
            if (isShowingNo_NetWork_AlertView == NO) {
                isShowingNo_NetWork_AlertView = YES;
                DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"网络不给力,请检查你的网络" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
                [alert show];
                [alert setCancelButtonAction:^{
                    isShowingNo_NetWork_AlertView = NO;
                }];
            }
            return;
        }
        return;
    }
    if (aView) {
        if (STRING_IS_NIL(tipMsg)) {
            tipMsg = @"加载中";
        }
        [PublicClass showViewHUDwithSuperView:aView andText:tipMsg];
    }
    QFHttpUrl *httpUrl = [QFHttpUrl sharedHttpUrl];
    NSString *hostName = [httpUrl defaulthostName];
    NSString *url = [hostName stringByAppendingString:[httpUrl urlOfRequestId:requestType]];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    
    [parameter addEntriesFromDictionary:params];
    AFHTTPSessionManager *manager = [YQNetworking manager];
    if (requestType == UserLoginType) {
        manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:0];
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        for (NSString *key in headers.allKeys) {
            if (headers[key] != nil) {
                [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
            }
        }
    }
    DLog(@"url ----- 当前请求的---%@\n?%@",url,parameter);
    [manager POST:url
       parameters:parameter
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask *task, id responseObject) {
             DLog(@"responseObject------%@\n",responseObject);
             if (finishBlock){
                 finishBlock(responseObject);
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [PublicClass clearViewViewHUDFromSuperView:aView];
             DLog(@"请求失败:--->%@",error.userInfo);
             //如果实现了失败回调，就走失败回调；
             if (failBlock) {
                 failBlock(error);
                 return ;
             }else{
                 [PublicClass showToastMessage:@"服务器异常" duration:1];
             }
             if (error.code == kQequestTimeout) {
                 DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"请求超时" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
                 [alert show];
                 return;
             }
         }
     ];
}
#pragma mark - post
+ (void)postWithRequestType:(RequestType)requestType withView:(UIView *)aView params:(id)params tipMsg:(NSString *)tipMsg
                finishBlock:(YQResponseSuccessBlock)finishBlock{
    [self postWithRequestType:requestType withView:aView params:params tipMsg:tipMsg finishBlock:finishBlock failBlock:nil];
}


#pragma mark - 文件上传
+ (void)uploadFileWithUrl:(NSString *)url
                 fileData:(NSData *)data
                     name:(NSString *)name param:(NSDictionary *)param
            progressBlock:(YQUploadProgressBlock)progressBlock
             successBlock:(YQResponseSuccessBlock)successBlock
                failBlock:(YQResponseFailBlock)failBlock {
    
    if(![[AppDelegate getAppDelegate] connection]) {
        DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"网络不给力,请检查你的网络" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
        [alert show];
        return;
    }
    AFHTTPSessionManager *manager = [self manager];
    [manager POST:url
       parameters:param
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    
    [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/png"];
    
} progress:^(NSProgress * _Nonnull uploadProgress) {
    if (progressBlock){progressBlock(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    }
} success:^(NSURLSessionDataTask *task, id responseObject) {
    if (successBlock) {
        successBlock(responseObject);
    }
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (failBlock) {
        failBlock(error);
    }
}];
}

#pragma mark - 多文件上传
+ (void)uploadMultFileWithUrl:(NSString *)url
                    fileDatas:(NSArray *)datas
                        names:(NSArray *)names
                        param:(NSDictionary *)param
                progressBlock:(YQUploadProgressBlock)progressBlock
                 successBlock:(YQResponseSuccessBlock)successBlock
                    failBlock:(YQResponseFailBlock)failBlock{
    if(![[AppDelegate getAppDelegate] connection]) {
        DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"网络不给力,请检查你的网络" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
        [alert show];
        return;
    }
    AFHTTPSessionManager *manager = [self manager];
    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < datas.count; i++) {
            [formData appendPartWithFileData:datas[i] name:names[i] fileName:[NSString stringWithFormat:@"%0d.png",i] mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        if (failBlock) {
            failBlock(error);
        }
    }];
    
}


+ (void)uploadMultFileWithUrl:(NSString *)url
                    fileDatas:(NSArray *)datas
                         type:(NSString *)type
                         name:(NSString *)name
                     mimeType:(NSString *)mimeTypes
                progressBlock:(YQUploadProgressBlock)progressBlock
                 successBlock:(YQMultUploadSuccessBlock)successBlock
                    failBlock:(YQMultUploadFailBlock)failBlock {
    
    if(![[AppDelegate getAppDelegate] connection]) {
        DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"网络不给力,请检查你的网络" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
        [alert show];
        return;
    }
    
    __block NSMutableArray *responses = [NSMutableArray array];
    __block NSMutableArray *failResponse = [NSMutableArray array];
    
    dispatch_group_t uploadGroup = dispatch_group_create();
    NSInteger count = datas.count;
    for (int i = 0; i < count; i++) {
        dispatch_group_enter(uploadGroup);
        [self uploadFileWithUrl:url
                       fileData:datas[i] name:name param:nil
                  progressBlock:^(int64_t bytesWritten, int64_t totalBytes) {
                      if (progressBlock) progressBlock(bytesWritten,
                                                       totalBytes);
                      
                  } successBlock:^(id response) {
                      [responses addObject:response];
                      dispatch_group_leave(uploadGroup);
                  } failBlock:^(NSError *error) {
                      NSError *Error = [NSError errorWithDomain:url code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"第%d次上传失败",i]}];
                      [failResponse addObject:Error];
                      dispatch_group_leave(uploadGroup);
                  }];
    }
    dispatch_group_notify(uploadGroup, dispatch_get_main_queue(), ^{
        if (responses.count > 0) {
            if (successBlock) {
                successBlock([responses copy]);
            }
        }
        if (failResponse.count > 0) {
            if (failBlock) {
                failBlock([failResponse copy]);
            }
        }
    });
}


//--------------------------------------------------------//
#pragma mark - get
+ (void)getWithRequestType:(RequestType)requestType withView:(UIView *)aView
                    params:(id)params tipMsg:(NSString *)tipMsg
               finishBlock:(YQResponseSuccessBlock)finishBlock
{
    
    if(![[AppDelegate getAppDelegate] connection]) {
        DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"网络不给力,请检查你的网络" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
        [alert show];
        return;
    }
    if (aView) {
        if (STRING_IS_NIL(tipMsg)) {
            tipMsg = @"加载中";
        }
        [PublicClass showViewHUDwithSuperView:aView andText:tipMsg];
    }
    QFHttpUrl *httpUrl = [QFHttpUrl sharedHttpUrl];
    NSString *hostName = [httpUrl defaulthostName];
    NSString *url = [hostName stringByAppendingString:[httpUrl urlOfRequestId:requestType]];
    //将session拷贝到堆中，block内部才可以获取得到session
    AFHTTPSessionManager *manager = [self manager];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter addEntriesFromDictionary:params];
    [manager GET:url
      parameters:params
        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (finishBlock) {
                finishBlock(responseObject);
            };
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (aView) {
                [PublicClass clearViewViewHUDFromSuperView:aView];
            }
            if (error.code == kQequestTimeout) {
                DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"请求超时" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
                [alert show];
                return;
            }
        }
     ];
}


#pragma mark - 下载
+ (void)downloadWithUrl:(NSString *)url
          progressBlock:(YQDownloadProgress)progressBlock
           successBlock:(YQDownloadSuccessBlock)successBlock
              failBlock:(YQDownloadFailBlock)failBlock {
    NSString *type = nil;
    NSArray *subStringArr = nil;
    NSURL *fileUrl = [[YQCacheManager shareManager] getDownloadDataFromCacheWithRequestUrl:url];
    
    if (fileUrl) {
        if (successBlock) {
            successBlock(fileUrl);
        }
        return ;
    }
    if (url) {
        subStringArr = [url componentsSeparatedByString:@"."];
        if (subStringArr.count > 0) {
            type = subStringArr[subStringArr.count - 1];
        }
    }
    
    AFHTTPSessionManager *manager = [self manager];
    //响应内容序列化为二进制
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progressBlock) progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (successBlock) {
                NSData *dataObj = (NSData *)responseObject;
                
                [[YQCacheManager shareManager] storeDownloadData:dataObj requestUrl:url];
                
                NSURL *downFileUrl = [[YQCacheManager shareManager] getDownloadDataFromCacheWithRequestUrl:url];
                
                successBlock(downFileUrl);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failBlock) {
                failBlock (error);
            }
        }
     ];
}

#pragma mark - other method
+ (void)setupTimeout:(NSTimeInterval)timeout {
    requestTimeout = timeout;
}

+ (void)configHttpHeader:(NSDictionary *)httpHeader {
    [headers addEntriesFromDictionary:httpHeader];
}

@end

@implementation YQNetworking (cache)
+ (NSUInteger)totalCacheSize {
    return [[YQCacheManager shareManager] totalCacheSize];
}

+ (NSUInteger)totalDownloadDataSize {
    return [[YQCacheManager shareManager] totalDownloadDataSize];
}

+ (void)clearDownloadData {
    [[YQCacheManager shareManager] clearDownloadData];
}

+ (NSString *)getDownDirectoryPath {
    return [[YQCacheManager shareManager] getDownDirectoryPath];
}

+ (NSString *)getCacheDiretoryPath {
    
    return [[YQCacheManager shareManager] getCacheDiretoryPath];
}

+ (void)clearTotalCache {
    [[YQCacheManager shareManager] clearTotalCache];
}

@end

