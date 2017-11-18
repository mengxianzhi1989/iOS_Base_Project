//
//  YQNetworking.m
//  YQNetworking
//
//  Created by yingqiu huang on 2017/2/10.
//  Copyright © 2017年 yingqiu huang. All rights reserved.
//

#import "YQNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "YQNetworking+RequestManager.h"
#import "YQCacheManager.h"

static NSMutableArray *requestTasksPool;
static NSMutableDictionary *headers;
static NSTimeInterval  requestTimeout = 40.f;

@interface YQNetworking()

@end

@implementation YQNetworking

+ (void)load{
    headers = [NSMutableDictionary dictionary];
}

#pragma mark - manager
+ (AFHTTPSessionManager *)manager {
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //默认解析模式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //配置请求序列化
    //    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    //    [serializer setRemovesKeysWithNullValues:YES];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    //    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //    manager.requestSerializer.timeoutInterval = requestTimeout;
    //    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    for (NSString *key in headers.allKeys) {
        if (headers[key] != nil) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    //配置响应序列化
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*",@"application/octet-stream",@"application/zip"]];
    
    //每次网络请求的时候，检查此时磁盘中的缓存大小，阈值默认是40MB，如果超过阈值，则清理LRU缓存,同时也会清理过期缓存，缓存默认SSL是7天，磁盘缓存的大小和SSL的设置可以通过该方法[YQCacheManager shareManager] setCacheTime: diskCapacity:]设置
    [[YQCacheManager shareManager] clearLRUCache];
    
    return manager;
}

+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasksPool == nil) requestTasksPool = [NSMutableArray array];
    });
    
    return requestTasksPool;
}

#pragma mark - get
+ (YQURLSessionTask *)getWithrequestType:(RequestType)requestType
                                  params:(NSDictionary *)params
                            successBlock:(YQResponseSuccessBlock)successBlock
                               failBlock:(YQResponseFailBlock)failBlock
{
    
    if(![[AppDelegate getAppDelegate] connection]) {
        DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"网络不给力,请检查你的网络" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
        [alert show];
        return nil;
    }
    
    QFHttpUrl *httpUrl = [QFHttpUrl sharedHttpUrl];
    NSString *hostName = [httpUrl defaulthostName];
    NSString *url = [hostName stringByAppendingString:[httpUrl urlOfRequestId:requestType]];
    
    //设置请求Header
    //    if (requestType == Querybycondition) {
    //        [self configHttpHeader:@{@"application/json; charset=utf-8":@"Contsetent-Type"}];
    //    }
    //    //添加其他信息
    //    if ([AppDelegate isLogin]) {
    //        [self configHttpHeader:@{@"key111":@"value111"}];
    //    }
    
    //将session拷贝到堆中，block内部才可以获取得到session
    __block YQURLSessionTask *session = nil;
    AFHTTPSessionManager *manager = [self manager];
    
    YJBaseVCtr *vc = (YJBaseVCtr *)[PubilcClass topViewController];
    [vc initWaitViewWithString:@"加载中"];
    session = [manager GET:url
                parameters:params
                  progress:^(NSProgress * _Nonnull downloadProgress) {
                      
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      if (successBlock) {
                          successBlock(responseObject);
                      };
                      [[self allTasks] removeObject:session];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      if (failBlock) {
                          [NSThread sleepForTimeInterval:2];
                          failBlock(error);
                      };
                      [[self allTasks] removeObject:session];
                  }];
    if ([self haveSameRequestInTasksPool:session]) {
        //取消新请求
        [session cancel];
        return session;
    }else {
        //无论是否有旧请求，先执行取消旧请求，反正都需要刷新请求
        YQURLSessionTask *oldTask = [self cancleSameRequestInTasksPool:session];
        if (oldTask) {
            [[self allTasks] removeObject:oldTask];
        }
        if (session) {
            [[self allTasks] addObject:session];
        }
        [session resume];
        return session;
    }
}

#pragma mark - post
+ (YQURLSessionTask *)postWithrequestType:(RequestType)requestType
                                   params:(NSDictionary *)params
                             successBlock:(YQResponseSuccessBlock)successBlock
                                failBlock:(YQResponseFailBlock)failBlock {
    
    if(![[AppDelegate getAppDelegate] connection]) {
        DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"网络不给力,请检查你的网络" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
        [alert show];
        return nil;
    }
    YJBaseVCtr *vc = (YJBaseVCtr *)[PubilcClass topViewController];
    [vc initWaitViewWithString:@"加载中"];
    
    QFHttpUrl *httpUrl = [QFHttpUrl sharedHttpUrl];
    NSString *hostName = [httpUrl defaulthostName];
    NSString *url = [hostName stringByAppendingString:[httpUrl urlOfRequestId:requestType]];
    
    __block YQURLSessionTask *session = nil;
    
    //    //设置请求Header
    //    if (requestType == Querybycondition) {
    //        [self configHttpHeader:@{@"application/json; charset=utf-8":@"Contsetent-Type"}];
    //    }
    //    //添加其他信息
    //    if ([AppDelegate isLogin]) {
    //        [self configHttpHeader:@{@"key111":@"value111"}];
    //    }
    
    AFHTTPSessionManager *manager = [self manager];
    session = [manager POST:url
                 parameters:params
                   progress:^(NSProgress * _Nonnull uploadProgress) {
                       
                   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                       if (successBlock){
                           NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                           successBlock(dictionary);
                       }
                       if ([[self allTasks] containsObject:session]) {
                           [[self allTasks] removeObject:session];
                       }
                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                       if (failBlock) {
                           failBlock(error);
                       }
                       if (error.code == -1011) {
                           DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"请求超时" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
                           [alert show];
                           return;
                       }
                       [[self allTasks] removeObject:session];
                   }];
    if ([self haveSameRequestInTasksPool:session]) {
        DLog(@"重复请求URL = %@",session.originalRequest)
        [session cancel];
        return session;
    }else {
        YQURLSessionTask *oldTask = [self cancleSameRequestInTasksPool:session];
        if (oldTask) {
            [[self allTasks] removeObject:oldTask];
        }
        if (session) {
            [[self allTasks] addObject:session];
        }
        [session resume];
        return session;
    }
}

#pragma mark - 文件上传
+ (YQURLSessionTask *)uploadFileWithUrl:(NSString *)url
                               fileData:(NSData *)data
                                   type:(NSString *)type
                                   name:(NSString *)name
                               mimeType:(NSString *)mimeType
                          progressBlock:(YQUploadProgressBlock)progressBlock
                           successBlock:(YQResponseSuccessBlock)successBlock
                              failBlock:(YQResponseFailBlock)failBlock {
    
    if(![[AppDelegate getAppDelegate] connection]) {
        DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"网络不给力,请检查你的网络" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
        [alert show];
        return nil;
    }
    __block YQURLSessionTask *session = nil;
    AFHTTPSessionManager *manager = [self manager];
    session = [manager POST:url
                 parameters:nil
  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
      NSString *fileName = nil;
      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
      formatter.dateFormat = @"yyyyMMddHHmmss";
      NSString *day = [formatter stringFromDate:[NSDate date]];
      fileName = [NSString stringWithFormat:@"%@.%@",day,type];
      [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
  } progress:^(NSProgress * _Nonnull uploadProgress) {
      if (progressBlock) progressBlock (uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      if (successBlock) successBlock(responseObject);
      [[self allTasks] removeObject:session];
      
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      if (failBlock) failBlock(error);
      [[self allTasks] removeObject:session];
  }];
    [session resume];
    if (session) {
        [[self allTasks] addObject:session];
    }
    return session;
}

#pragma mark - 多文件上传
+ (NSArray *)uploadMultFileWithUrl:(NSString *)url
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
        return nil;
    }
    
    __block NSMutableArray *sessions = [NSMutableArray array];
    __block NSMutableArray *responses = [NSMutableArray array];
    __block NSMutableArray *failResponse = [NSMutableArray array];
    
    dispatch_group_t uploadGroup = dispatch_group_create();
    NSInteger count = datas.count;
    for (int i = 0; i < count; i++) {
        __block YQURLSessionTask *session = nil;
        dispatch_group_enter(uploadGroup);
        session = [self uploadFileWithUrl:url
                                 fileData:datas[i]
                                     type:type name:name
                                 mimeType:mimeTypes
                            progressBlock:^(int64_t bytesWritten, int64_t totalBytes) {
                                if (progressBlock) progressBlock(bytesWritten,
                                                                 totalBytes);
                                
                            } successBlock:^(id response) {
                                [responses addObject:response];
                                dispatch_group_leave(uploadGroup);
                                [sessions removeObject:session];
                            } failBlock:^(NSError *error) {
                                NSError *Error = [NSError errorWithDomain:url code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"第%d次上传失败",i]}];
                                
                                [failResponse addObject:Error];
                                
                                dispatch_group_leave(uploadGroup);
                                
                                [sessions removeObject:session];
                            }];
        [session resume];
        if (session) {
            [sessions addObject:session];
        }
    }
    [[self allTasks] addObjectsFromArray:sessions];
    dispatch_group_notify(uploadGroup, dispatch_get_main_queue(), ^{
        if (responses.count > 0) {
            if (successBlock) {
                successBlock([responses copy]);
                if (sessions.count > 0) {
                    [[self allTasks] removeObjectsInArray:sessions];
                }
            }
        }
        if (failResponse.count > 0) {
            if (failBlock) {
                failBlock([failResponse copy]);
                if (sessions.count > 0) {
                    [[self allTasks] removeObjectsInArray:sessions];
                }
            }
        }
    });
    return [sessions copy];
}

#pragma mark - 下载
+ (YQURLSessionTask *)downloadWithUrl:(NSString *)url
                        progressBlock:(YQDownloadProgress)progressBlock
                         successBlock:(YQDownloadSuccessBlock)successBlock
                            failBlock:(YQDownloadFailBlock)failBlock {
    NSString *type = nil;
    NSArray *subStringArr = nil;
    __block YQURLSessionTask *session = nil;
    
    NSURL *fileUrl = [[YQCacheManager shareManager] getDownloadDataFromCacheWithRequestUrl:url];
    
    if (fileUrl) {
        if (successBlock) successBlock(fileUrl);
        return nil;
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
    
    session = [manager GET:url
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
                  }];
    
    [session resume];
    if (session) {
        [[self allTasks] addObject:session];
    }
    return session;
}

#pragma mark - other method
+ (void)setupTimeout:(NSTimeInterval)timeout {
    requestTimeout = timeout;
}

+ (void)cancleAllRequest {
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(YQURLSessionTask  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[YQURLSessionTask class]]) {
                [obj cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)url {
    if (!url) return;
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(YQURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[YQURLSessionTask class]]) {
                if ([obj.currentRequest.URL.absoluteString hasSuffix:url]) {
                    [obj cancel];
                    *stop = YES;
                }
            }
        }];
    }
}

+ (void)configHttpHeader:(NSDictionary *)httpHeader {
    [headers addEntriesFromDictionary:httpHeader];
    DLog(@"headers %@",headers);
}

+ (NSArray *)currentRunningTasks {
    return [[self allTasks] copy];
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

